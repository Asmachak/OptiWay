const {generateID} = require("../middleware/generateID");
const Reservation = require("../models/reservation");
const ReservationParking = require("../models/reservation_parking");
const Vehicule = require("../models/vehicule");

async function handleAddVehicule(req, res) {
  try {
    const formData = req.body;
    const params = req.params;
    const idVehicule = generateID();

    const vehicule = await Vehicule.create({
      id: idVehicule,
      matricule: formData.matricule,
      marque: formData.marque,
      model:formData.model,
      iduser:params.iduser,
      color:formData.color,      
    });
    console.log("formData" );

    vehicleWithState = {
        ...vehicule.toJSON(), // Convert the vehicle instance to JSON
        state: "available",
      };
    

    return res.status(200).json(vehicleWithState);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling Add vehicule");
  }
}

async function vehiculeListe(req, res) {
  try {
    const { iduser } = req.params;

    // Fetch all vehicles for the given user
    const vehicules = await Vehicule.findAll({
      where: {
        iduser: iduser,
      },
    });

    // Check if each vehicle is reserved and add the "state" field
    const vehiculesWithState = await Promise.all(
      vehicules.map(async (vehicule) => {
        // Check if the vehicle is reserved
        const isReserved = await ReservationParking.findOne({
          where: { idvehicule: vehicule.id , state:"in progress" },
        });

        // Add the "state" field: "reserved" or "available"
        return {
          ...vehicule.toJSON(), // Convert the vehicle instance to JSON
          state: isReserved ? "reserved" : "available",
        };
      })
    );

    // Return the updated list with the state field
    return res.status(200).json(vehiculesWithState);
  } catch (error) {
    console.error("Error:", error);
    return res.status(500).send("Error occurred when listing vehicles by userID");
  }
}


async function handleDeleteVehicule(req, res) {
  try {
    const params = req.params;

    const vehicule = await Vehicule.destroy({
     where : {
      id : params.id
     }
      
    });

    return res.status(200).json("Vehicule is deleted successfully");
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling Destroy vehicule");
  }
}



module.exports = {handleAddVehicule,vehiculeListe,handleDeleteVehicule}
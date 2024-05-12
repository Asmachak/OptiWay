const {generateID} = require("../middleware/generateID");
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
      color:formData.color
      
    });
    console.log("formData" );

    return res.status(200).json(vehicule);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling Add vehicule");
  }
}

async function vehiculeListe(req, res) {
  try {
    const params = req.params;

    const vehicules = await Vehicule.findAll({
      where : {
        iduser:params.iduser
      }
    });

    return res.status(200).json(vehicules);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when Listing vehicules by userID");
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
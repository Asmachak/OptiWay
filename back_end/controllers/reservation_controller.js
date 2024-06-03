const Reservation = require("../models/reservation");
const {generateID} = require("../middleware/generateID");
const Parking = require("../models/parking");
const User = require("../models/user");
const { where } = require("sequelize");
const Vehicule = require("../models/vehicule");

async function handleAddReservation(req, res) {
  try {
    const formData = req.body;
    const idReserv = generateID();
    console.log(formData);

    let capacityCheck = true;
    let parking;
    let event;

    if (formData.idparking != null) {
      parking = await Parking.findByPk(formData.idparking);
      capacityCheck = parking.capacity > 0;
    }

    if (formData.idevent != null) {
      event = await Event.findByPk(formData.idevent);
      capacityCheck = capacityCheck && event.capacity > 0;
    }

    if (!capacityCheck) {
      return res.status(500).send("Parking or event is full");
    }

    if (parking) {
      await parking.update({ capacity: parking.capacity - 1 });
    }

    if (event) {
      await event.update({ capacity: event.capacity - 1 });
    }

    const reservation = await Reservation.create({
      id: idReserv,
      CreatedAt: new Date(),
      EndedAt: formData.EndedAt,
      state: "in progress",
      iduser: formData.iduser,
      idevent: formData.idevent,
      idparking: formData.idparking,
      idvehicule:formData.idvehicule
    });

    return res.status(200).json( reservation );
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling Add reservation");
  }
}

async function getReservation(req, res) {
  try {
    const { userid } = req.params;

    const user = await User.findByPk(userid);
    if (!user) {
      return res.status(404).send("User not found!");
    }

    const reservations = await Reservation.findAll({
      where: { iduser: userid },
      include: [
        {
          model: Parking,
        
        },
        {
          model: Vehicule,
          
        },
        {
          model: User,

        }

      ],
    });

    if (!reservations || reservations.length === 0) {
      return res.status(200).send("No reservations found for the user.");
    }

    res.status(200).send(reservations);
  } catch (error) {
    res.status(500).send("Error occurred when handling get reservation: " + error);
  }
}


async function changeReservationState() {
  try {
    // Define the current date
    const today = new Date();

    // Find all reservations with state "in progress"
    const reservations = await Reservation.findAll({
      where: {
        state: 'in progress',
      },
    });
    
    // Iterate through the reservations and update their state if EndedAt < today
    for (const reservation of reservations) {
      if (reservation.EndedAt < today) {
        const parking = await Parking.findByPk(
          reservation.idparking
        );
        await reservation.update({ state: 'ended' }); // Change the state as needed
        await parking.update({ capacity: parking.capacity+1 });
      }
    }
    
    console.log('Reservations updated successfully');
  } catch (error) {
    console.error('Error occurred when handling changing reservation:', error);
  }
}

// Run the function every second
setInterval(changeReservationState, 1000);

module.exports = {handleAddReservation,getReservation}
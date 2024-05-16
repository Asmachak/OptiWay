const Reservation = require("../models/reservation");
const {generateID} = require("../middleware/generateID");
const Parking = require("../models/parking");
const User = require("../models/user");

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
    const params = req.params; // Corrected typo 'res.params' to 'req.params'

    const user = await User.findByPk(params.userid); // Added 'await' to ensure asynchronous operation completion
    console.log(params.userid);
    if (user) {
      const reservations = await Reservation.findAll({ // Corrected the usage of 'where' clause
        where: {
          iduser: params.userid, // Changed "userid" to "userId" for consistency
        },
      });

      if (reservations) {
        res.status(200).send(reservations);
      } else {
        res.status(500).send("No reservations found for the user.");
      }
    } else {
      res.status(500).send("User not found!");
    }
  } catch (error) {
    res.status(500).send("Error occurred when handling get reservation: " + error); // Concatenated error message with the actual error
  }
}



module.exports = {handleAddReservation,getReservation}
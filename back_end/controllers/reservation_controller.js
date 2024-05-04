const Reservation = require("../models/reservation");
const {generateID} = require("../middleware/generateID");
const Parking = require("../models/parking");

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
    });

    return res.status(200).json( reservation );
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling Add reservation");
  }
}


module.exports = {handleAddReservation}
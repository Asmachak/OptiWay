const Reservation = require("../models/reservation");
const {generateID} = require("../middleware/generateID");
const Parking = require("../models/parking");
const User = require("../models/user");
const { where } = require("sequelize");
const Vehicule = require("../models/vehicule");
const moment = require('moment'); 
const { averageRate } = require("./rate_controller");
const ReservationParking = require("../models/reservation_parking");
const ReservationEvent = require("../models/reservation_event");


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
      if (!parking) {
        return res.status(404).send("Parking not found");
      }
      capacityCheck = parking.capacity > 0;
      
      let reservations = await Reservation.findAll({ 
        where: {
          idvehicule: formData.idvehicule,
          state: ["in progress", "extended"]
        }
      });

      if (reservations.length > 0) {
        return res.status(400).send("The car is already taken!");
      }
    }

    if (formData.idevent != null) {
      event = await Event.findByPk(formData.idevent);
      if (!event) {
        return res.status(404).send("Event not found");
      }
      capacityCheck = capacityCheck && event.capacity > 0;
    }

    if (!capacityCheck) {
      return res.status(400).send("Parking or event is full");
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
      idResEvent: formData.idResEvent,
      idResParking: formData.idResParking,
      amount: formData.amount,

    });

    return res.status(200).json(reservation);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling add reservation");
  }
}

async function getReservation(req, res) {
    try {
      const { userid } = req.params;
  
      const user = await User.findByPk(userid);
      if (!user) {
        return res.status(404).send("User not found!");
      }
  
      let reservations = await Reservation.findAll({
        where: { iduser: userid },
        include: [
          {
            model: ReservationEvent,
          },
          {
            model: ReservationParking,
            include: [{ model: Vehicule },{ model: Parking }],
          },
          {
            model: User,
          },
        ],
      });
  
      if (!reservations || reservations.length === 0) {
        return res.status(200).send("No reservations found for the user.");
      }
  
      const reservationsWithRate = await Promise.all(
        reservations.map(async (reservation) => {
          const parkingData = reservation.reservationParking.Parking;
          const vehicleData = reservation.reservationParking.Vehicule;

          console.log(reservation.reservationParking);
  
          if (parkingData) {
            const rate = await averageRate(parkingData.id);
            parkingData.rate = rate;
          }
  
          return {
            id: reservation.id,
            CreatedAt: reservation.CreatedAt,
            EndedAt: reservation.EndedAt,
            state: reservation.state,
            amount: reservation.amount,
            iduser: reservation.iduser,
            idResEvent: reservation.idResEvent,
            idResParking: reservation.idResParking,
            ReservationEvent: reservation.reservationEvent,
            ReservationParking:reservation.reservationParking,
            User: reservation.user,
          };
        })
      );
  
      res.status(200).json(reservationsWithRate);
    } catch (error) {
      console.error("Error:", error);
      res.status(500).send("Error occurred when handling get reservation: " + error);
    }
  }

async function extendReservation(req, res) {
  try {
    const id = req.params.id; 
    let { EndedAt } = req.body;

    // Parse the date and format it to match the database format
    EndedAt = moment(EndedAt).format('YYYY-MM-DD HH:mm:ssZ');

    const reservation = await Reservation.findByPk(id);
    if (!reservation) {
      return res.status(404).send("Reservation not found!");
    }

    const parking = await Parking.findByPk(reservation.idparking);
    if (!parking) {
      return res.status(404).send("Parking not found!");
    }

    console.log("Form Data:", req.body);
    console.log("Formatted EndedAt:", EndedAt);
    console.log("Reservation:", reservation);
    console.log("Parking:", parking);

    // Check if reservation is not ended and parking capacity is not 0
    if (reservation.state !== "ended" && parking.capacity !== 0) {
      await Reservation.update(
        { EndedAt: EndedAt, state: "extended" },
        { where: { id: id } }
      );

      // Reload the updated reservation to get the updated data
      const updatedReservation = await Reservation.findByPk(id);

      res.status(200).send(updatedReservation);
    } else {
      return res.status(400).send("Can't extend an ended reservation or parking is full");
    }
  } catch (error) {
    console.error("Error occurred when extending reservation:", error);
    res.status(500).send("Error occurred when extending reservation: " + error.message);
  }
}


async function changeReservationState() {
  try {
    // Define the current date
    const today = new Date();

    // Find all reservations with state "in progress"
    const reservations = await Reservation.findAll({
      where: {
        state: ['in progress', 'extended'],
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
//setInterval(changeReservationState, 1000);

module.exports = {handleAddReservation,getReservation,extendReservation}
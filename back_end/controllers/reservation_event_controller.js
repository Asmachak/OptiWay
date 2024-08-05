const Reservation = require("../models/reservation");
const Parking = require("../models/parking");
const moment = require('moment');
const { v4: uuidv4 } = require('uuid');
const Event = require('../models/event');
const ReservationEvent = require('../models/reservation_event');
const ReservationParking = require('../models/reservation_parking');


async function handleAddReservationEvent(req, res) {
  try {
      const params = req.params;
      const formData = req.body;

      // Generate unique IDs
      const idReservEvent = uuidv4();
      const idReservParking = uuidv4();
      const idReserv = uuidv4();

      console.log(formData);
      let event;
      let parking;
      let capacityCheck = true;

      // Specify the date format for parsing
      const dateFormat = 'YYYY-MM-DDTHH:mm:ss.SSSZ';
      const EndedAt = moment(formData.EndedAt, dateFormat, true);
      if (!EndedAt.isValid()) {
          return res.status(400).send("Invalid date format. Please use 'DD-MM-YYYY'.");
      }

      const formattedEndedAt = EndedAt.format('YYYY-MM-DD HH:mm:ss');

      event = await Event.findByPk(params.idevent);

      if (!event) {
          return res.status(404).send("Event not found");
      }

      // Check parking capacity and existing reservations for the vehicle
      if (formData.parking) {
          parking = await Parking.findOne({
              where: {
                  parkingName: formData.parking
              }
          });
          if (!parking) {
              return res.status(404).send("Parking not found");
          }
          capacityCheck = parking.capacity > 0;

          let reservations = await ReservationParking.findAll({
              where: {
                  idvehicule: params.idvehicule,
                  state: ["in progress", "extended"]
              }
          });

          if (reservations.length > 0) {
              return res.status(400).send("The car is already taken!");
          }
      }

      // Update parking capacity if applicable
      if (parking) {
          await parking.update({ capacity: parking.capacity - 1 });
      }

      // Create ReservationEvent record if applicable
      let reservationEvent = null;
      if (params.idevent) {
          reservationEvent = await ReservationEvent.create({
              id: idReservEvent,
              CreatedAt: new Date(),
              EndedAt: formattedEndedAt,
              state: "in progress",
              Nbreticket: formData.Nbreticket,
              iduser: params.iduser,
              idevent: params.idevent,
              tarif: event.price * formData.Nbreticket,
          });
      }

      // Create ReservationParking record if applicable
      let reservationParking = null;
      if (formData.parking) {
          reservationParking = await ReservationParking.create({
              id: idReservParking,
              CreatedAt: new Date(),
              EndedAt: formattedEndedAt,
              state: "in progress",
              iduser: params.iduser,
              idparking: parking.id,
              idvehicule: params.idvehicule,
              tarif: 10,
          });
      }

      // Ensure the ReservationParking record was created successfully
      const reservationParkingId = reservationParking ? reservationParking.id : null;

      // Create Reservation record
      const reservation = await Reservation.create({
          id: idReserv,
          CreatedAt: new Date(),
          EndedAt: formattedEndedAt,
          state: "in progress",
          iduser: params.iduser,
          idResParking: reservationParkingId,
          idResEvent: idReservEvent,
          amount: reservationEvent.tarif + reservationParking.tarif,
          idvehicule: params.idvehicule
      });

      // Send successful response
      return res.status(200).send(reservationEvent);
  } catch (error) {
      console.error("Error:", error);
      res.status(500).send(error);
  }
}

  
async function changeReservationState() {
  try {
    // Define the current date
    const today = new Date();

    // Find all reservations with state "in progress" or "extended"
    const reservations = await Reservation.findAll({
      where: {
        state: ['in progress', 'extended'],
      },
    });

    // Iterate through the reservations and update their state if EndedAt < today
    for (const reservation of reservations) {
      let reservationParking = await ReservationParking.findByPk(reservation.idResParking);
      if (!reservationParking) {
        console.error(`ReservationParking not found for id: ${reservation.idResParking}`);
        continue;
      }

      if (reservation.EndedAt < today) {
        const parking = await Parking.findByPk(reservationParking.idparking);
        if (!parking) {
          console.error(`Parking not found for id: ${reservationParking.idparking}`);
          continue;
        }

        await reservation.update({ state: 'ended' }); // Change the state as needed
        await parking.update({ capacity: parking.capacity + 1 });
      }
    }

    console.log('Reservations updated successfully');
  } catch (error) {
    console.error('Error occurred when handling changing reservation:', error);
  }
}


module.exports = { handleAddReservationEvent };

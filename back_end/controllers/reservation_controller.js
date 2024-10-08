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
const Event = require("../models/event");
const Rate = require("../models/rate");
const ReservationEventParking = require("../models/reservation_event_parking");



// async function handleAddReservation(req, res) {
//   try {
//     const formData = req.body;
//     const idReserv = generateID();
//     console.log(formData);

//     let capacityCheck = true;
//     let parking;
//     let event;

//     if (formData.idparking != null) {
//       parking = await Parking.findByPk(formData.idparking);
//       if (!parking) {
//         return res.status(404).send("Parking not found");
//       }
//       capacityCheck = parking.capacity > 0;
      
//       let reservations = await Reservation.findAll({ 
//         where: {
//           idvehicule: formData.idvehicule,
//           state: ["in progress", "extended"]
//         }
//       });

//       if (reservations.length > 0) {
//         return res.status(400).send("The car is already taken!");
//       }
//     }

//     if (formData.idevent != null) {
//       event = await Event.findByPk(formData.idevent);
//       if (!event) {
//         return res.status(404).send("Event not found");
//       }
//       capacityCheck = capacityCheck && event.capacity > 0;
//     }

//     if (!capacityCheck) {
//       return res.status(400).send("Parking or event is full");
//     }

//     if (parking) {
//       await parking.update({ capacity: parking.capacity - 1 });
//     }

//     if (event) {
//       await event.update({ capacity: event.capacity - 1 });
//     }

//     const reservation = await Reservation.create({
//       id: idReserv,
//       CreatedAt: new Date(),
//       EndedAt: formData.EndedAt,
//       state: "in progress",
//       iduser: formData.iduser,
//       idResEvent: formData.idResEvent,
//       idResParking: formData.idResParking,
//       amount: formData.amount,

//     });

//     return res.status(200).json(reservation);
//   } catch (error) {
//     console.error("Error:", error);
//     res.status(500).send("Error occurred when handling add reservation");
//   }
// }

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
          model: ReservationEvent,
          include: [{ model: Event }],
        },
        {
          model: ReservationParking,
          include: [{ model: Vehicule }, { model: Parking }],
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
        const reservationParking = reservation.reservationParking;
        const parkingData = reservationParking ? reservationParking.parking : null;

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
          ReservationParking: reservation.reservationParking,
          User: reservation.user,
        };
      })
    );

    res.status(200).json(reservationsWithRate);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Error occurred when handling get reservation: " + error.message);
  }
}

async function getEventReservationOrganiser(req, res) {
  try {
    const { organiserid } = req.params;

    // Fetch all events for the organiser
    const events = await Event.findAll({
      where: {
        idOrganiser: organiserid
      }
    });

    // Check if no events were found
    if (!events || events.length === 0) {
      return res.status(404).send({ message: "No events found for this organiser" });
    }

    // Array to collect all event reservations
    const result = [];

    // Fetch reservations and user details for each event
    for (const event of events) {
      const reservations = await ReservationEvent.findAll({
        where: {
          idevent: event.id
        }
      });

      // Fetch user data for each reservation asynchronously
      const reservationsWithUser = await Promise.all(
        reservations.map(async (reservation) => {
          const user = await User.findByPk(reservation.iduser);  // Fetch all user attributes

          return {
            reservation: reservation,
            userId: reservation.iduser,
            user: user ? user.toJSON() : null,  // Include all user attributes as JSON
            tickets: reservation.Nbreticket,
            state: reservation.state,
            createdAt: reservation.CreatedAt,
            endedAt: reservation.EndedAt
          };
        })
      );

      result.push({
        event: event,
        reservations: reservationsWithUser
      });
    }

    // Send the result as JSON
    return res.status(200).json(result);
  } catch (error) {
    console.error("Error occurred when getting events:", error);
    return res.status(500).send("Error occurred when getting events: " + error.message);
  }
}


async function extendReservation(req, res) {
  try {
    const {id} = req.params; 
    let { EndedAt } = req.body;
    
    // Parse the date and format it to match the database format
    EndedAt = moment(EndedAt).format('YYYY-MM-DD HH:mm:ssZ');

    const reservation = await Reservation.findByPk(id);
    
    const reservationParking = await ReservationParking.findByPk(reservation.idResParking);

    console.log("Form Data:", req.body);
    console.log("Formatted EndedAt:", EndedAt);
    console.log("Reservation:", reservation);
    console.log("id:", reservationParking);

    
    if (!reservation) {
      return res.status(404).send("Reservation not found!");
    }

    const parking = await Parking.findByPk(reservationParking.idparking);
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

      //const resPArking = await updatedReservation(id,EndedAt);

      

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

    // Find all reservations with state "in progress" or "extended"
    const reservations = await Reservation.findAll({
      where: {
        state: ['in progress', 'extended'],
      },
    });

    // Iterate through the reservations and update their state if EndedAt < today
    for (const reservation of reservations) {
      let reservationParking = await ReservationParking.findByPk(reservation.idResParking);
      let reservationEvent = await ReservationEvent.findByPk(reservation.idResEvent);

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

        if (reservationEvent) {
          await reservationEvent.update({ state: 'ended' });
        } else {
          console.error(`ReservationEvent not found for id: ${reservation.idResEvent}`);
        }

        await reservationParking.update({ state: 'ended' });
        await reservation.update({ state: 'ended' }); // Change the state as needed
        await parking.update({ capacity: parking.capacity + 1 });
      }
    }

    console.log('Reservations updated successfully');
  } catch (error) {
    console.error('Error occurred when handling changing reservation:', error);
  }
}


async function deleteReservation(req, res) {
  try {
    const { id } = req.params;

    // Find the reservation by its ID
    const reservation = await Reservation.findByPk(id);

    // If reservation not found, return a 404 response
    if (!reservation) {
      return res.status(404).send("Reservation not found!");
    }

    // Delete associated ReservationParking if it exists
    if (reservation.idResParking) {
      await ReservationParking.destroy({ where: { id: reservation.idResParking } });
    }

    // Delete associated ReservationEvent if it exists
    if (reservation.idResEvent) {
      await ReservationEvent.destroy({ where: { id: reservation.idResEvent } });
    }

    // Delete associated Rates if they reference the reservation
    await Rate.destroy({ where: { reservation: id } });

    // Delete the reservation
    await reservation.destroy();

    // Send a success response
    res.status(200).send("Reservation deleted successfully.");
  } catch (error) {
    console.error("Error occurred when deleting reservation:", error);
    res.status(500).send("Error occurred when deleting reservation: " + error.message);
  }
}

async function cancelReservation(req, res) {
  try {
    const { id } = req.params;

    // Find the reservation by its ID
    const reservation = await Reservation.findByPk(id);

    // If reservation not found, return a 404 response
    if (!reservation) {
      return res.status(404).send("Reservation not found!");
    }

    // Update the state of associated ReservationParking to "ended" if it exists
    if (reservation.idResParking) {
      await ReservationParking.update(
        { state: 'ended' }, // Set state to "ended"
        { where: { id: reservation.idResParking } }
      );
    }

    // Update the state of associated ReservationEvent to "ended" if it exists
    if (reservation.idResEvent) {
      await ReservationEvent.update(
        { state: 'ended' }, // Set state to "ended"
        { where: { id: reservation.idResEvent } }
      );
    }

    // Update the state of the reservation itself to "ended"
    await reservation.update({ state: 'ended' });

    // Send a success response
    res.status(200).send("Success");
  } catch (error) {
    console.error("Error occurred when cancelling reservation:", error);
    res.status(500).send("Error occurred when cancelling reservation: " + error.message);
  }
}

  
// Run the function every second
setInterval(changeReservationState, 1000);
module.exports = {getReservation,extendReservation,deleteReservation,getEventReservationOrganiser,cancelReservation}
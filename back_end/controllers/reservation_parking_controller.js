const Reservation = require("../models/reservation");
const Parking = require("../models/parking");
const User = require("../models/user");
const Vehicule = require("../models/vehicule");
const moment = require('moment'); 
const { averageRate } = require("./rate_controller");
const { v4: uuidv4 } = require('uuid');
const ReservationParking = require("../models/reservation_parking");


async function handleAddReservationParking(req, res) {
  try {
    const params = req.params;
    const formData = req.body;
    const idReserv = uuidv4();
    const idRes = uuidv4();

    console.log(formData);

    var capacityCheck = true;
    let parking;

    if (params.idparking != null) {
      parking = await Parking.findByPk(params.idparking);
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

    if (parking) {
      await parking.update({ capacity: parking.capacity - 1 });
    }

   
    const reservation = await ReservationParking.create({
      id: idReserv,
      CreatedAt: new Date(),
      EndedAt: formData.EndedAt,
      state: "in progress",
      iduser: params.iduser,
      idparking: params.idparking,
      idvehicule: params.idvehicule,
      tarif: formData.tarif,
    });

    const resss = await Reservation.create({
      id: idRes,
      CreatedAt: reservation.CreatedAt,
      EndedAt: reservation.EndedAt,
      state: "in progress",
      iduser: params.iduser,
      idResParking: idReserv,
      idResEvent: null,
      amount: formData.tarif,
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
        { model: Parking },
        { model: Vehicule },
        { model: User }
      ],
    });

    console.log(reservations);
    if (!reservations || reservations.length === 0) {
      return res.status(200).send("No reservations found for the user.");
    }
    var tab=[]
    // Loop through reservations and add the average rate to each parking
    for (let i = 0; i < reservations.length; i++) {
      if (reservations[i]["parking"]) {
        // Convert reservation["parking"] to a plain JavaScript object
        var parkingData = reservations[i]["parking"].toJSON();

        // Calculate the rate
        const rate = await averageRate(parkingData.id);

        // Add the rate to the parking data
        parkingData.rate = rate;

        // Log the updated parking data with rate
        console.log("Updated parking data:", parkingData);
        tab[i]={
          id: reservations[i].id,
          CreatedAt: reservations[i].CreatedAt,
          EndedAt: reservations[i].EndedAt,
          state: reservations[i].state,
          iduser: reservations[i].iduser,
          idevent: reservations[i].idevent,
          idparking: reservations[i].idparking,
          idvehicule: reservations[i].idvehicule,
          parking:parkingData,
          user:reservations[i].user,
          vehicle:reservations[i].vehicule,
          amount:reservations[i].amount,};


        reservations[i].parking=parkingData;

      }
    }

   

    console.log(tab)
    res.status(200).send(tab);
  } catch (error) {
    res.status(500).send("Error occurred when handling get reservation: " + error);
  }
}

async function extendReservation( id, EndedAt ) {
  try {
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

module.exports = {handleAddReservationParking,getReservation,extendReservation}
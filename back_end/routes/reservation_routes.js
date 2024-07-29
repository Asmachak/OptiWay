const express = require('express');
const { handleAddReservationParking} = require("../controllers/reservation_parking_controller");
const { handleAddReservation, getReservation } = require('../controllers/reservation_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/reservationParking/addRes/:iduser/:idparking/:idvehicule',handleAddReservationParking);
router.post('/reservation/addRes',handleAddReservation);
router.get('/reservation/:userid',getReservation);



module.exports = router;

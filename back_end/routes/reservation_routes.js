const express = require('express');
const { handleAddReservationParking, getAllReservations} = require("../controllers/reservation_parking_controller");
const { getReservation, extendReservation, deleteReservation,getEventReservationOrganiser, cancelReservation } = require('../controllers/reservation_controller');
const { handleAddReservationEvent } = require('../controllers/reservation_event_controller');
const router = express.Router();


/************************************ reservation routes *****************************************/


router.post('/reservationParking/addRes/:iduser/:idparking/:idvehicule',handleAddReservationParking);
//router.post('/reservation/addRes',handleAddReservation);
router.post('/extendReservation/:id',extendReservation);
router.post('/cancelReservation/:id',cancelReservation);
router.get('/reservation/:userid',getReservation);
router.post('/reservationEvent/addRes/:iduser/:idvehicule/:idevent',handleAddReservationEvent);
router.delete('/reservation/:id', deleteReservation);
router.get('/reservationOrganiser/:organiserid',getEventReservationOrganiser);
router.get('/admin/Resparking',getAllReservations);





module.exports = router;

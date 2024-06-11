const express = require('express');
const { handleAddReservation, getReservation,extendReservation } = require("../controllers/reservation_controller");
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/reservation/addRes',handleAddReservation);
router.post('/extendReservation/:id',extendReservation);
router.get('/reservation/:userid',getReservation);



module.exports = router;

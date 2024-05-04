const express = require('express');
const { handleAddReservation } = require("../controllers/reservation_controller");
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/reservation/addRes',handleAddReservation);


module.exports = router;

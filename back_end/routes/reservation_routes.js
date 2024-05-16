const express = require('express');
const { handleAddReservation, getReservation } = require("../controllers/reservation_controller");
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/reservation/addRes',handleAddReservation);
router.get('/reservation/:userid',getReservation);



module.exports = router;

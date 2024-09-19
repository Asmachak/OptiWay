const express = require('express');
const { getAllParkings,getParkingByID} = require("../controllers/parking_controller");
const router = express.Router();


/************************************ parking routes *****************************************/


router.get('/parking',getAllParkings);
router.get('/parking/:parkingid',getParkingByID);


module.exports = router;
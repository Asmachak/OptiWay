const express = require('express');
const { getAllParkings } = require("../controllers/parking_controller");
const router = express.Router();


/************************************ parking routes *****************************************/


router.get('/parking',getAllParkings);


module.exports = router;
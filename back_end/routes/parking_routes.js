const express = require('express');
const { getDataFromCSV } = require("../controllers/parking_controller");
const router = express.Router();


/************************************ parking routes *****************************************/


router.get('/parking',getDataFromCSV);


module.exports = router;

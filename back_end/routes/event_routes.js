const express = require('express');
const { handleAddEvent } = require('../controllers/event_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/event/addEvent',handleAddEvent);


module.exports = router;
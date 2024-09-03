const express = require('express');
const { handleAddEvent } = require('../controllers/event_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.put('/event/addEvent/:idOrganiser',handleAddEvent);


module.exports = router;
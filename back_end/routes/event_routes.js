const express = require('express');
const { handleAddEvent, deleteEvent, getEvents, updateEvent } = require('../controllers/event_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.put('/event/addEvent/:idOrganiser',handleAddEvent);
router.delete('/event/deleteEvent/:eventId',deleteEvent);
router.get('/event/getEvent/:idOrganiser',getEvents);
router.post('/event/updateEvent/:eventId',updateEvent);





module.exports = router;
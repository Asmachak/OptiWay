const express = require('express');
const { getNotifications } = require('../controllers/notification_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.get('/notification/:id',getNotifications);


module.exports = router;
const express = require('express');
const { getNotifications, deleteNotification } = require('../controllers/notification_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.get('/notification/:id',getNotifications);
router.delete('/deleteNotification/:id',deleteNotification);



module.exports = router;
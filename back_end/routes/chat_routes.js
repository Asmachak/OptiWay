const express = require('express');
const { getChatHistory } = require('../controllers/chat_controller');
const router = express.Router();


/************************************ parking routes *****************************************/



router.get('/history/:from/:to', getChatHistory);

module.exports = router;



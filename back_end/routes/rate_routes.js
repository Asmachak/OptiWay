const express = require('express');
const { giveRate, checkRate, updateRate } = require('../controllers/rate_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/rate/:userid/:resid',giveRate);
router.get('/rate/:resid',checkRate);
router.post('/update/rate/:resid',updateRate);




module.exports = router;
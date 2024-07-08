
const express = require('express');
const { paiement } = require('../controllers/paiement_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/create-payment-intent',paiement);

module.exports = router;
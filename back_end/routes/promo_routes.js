const express = require('express');
const { handleAddPromo, getPromoByEventId, getPromoList, DeletePromo } = require('../controllers/promo_controller');
const router = express.Router();


/************************************ parking routes *****************************************/


router.post('/promo/addPromo/:idevent',handleAddPromo);
router.get('/promo/getPromo/:idevent',getPromoByEventId);
router.get('/promo/getPromo',getPromoList);
router.delete('/promo/deletePromo/:id',DeletePromo);





module.exports = router;
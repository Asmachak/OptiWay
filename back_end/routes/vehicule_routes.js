const express = require('express');
const { handleAddVehicule, vehiculeListe } = require("../controllers/vehicule_controller");
const router = express.Router();


/************************************ parking routes *****************************************/

router.get('/vehicule/:iduser',vehiculeListe);
router.post('/vehicule/addVeh/:iduser',handleAddVehicule);


module.exports = router;

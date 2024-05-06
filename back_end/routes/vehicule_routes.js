const express = require('express');
const { handleAddVehicule, vehiculeListe, handleDeleteVehicule } = require("../controllers/vehicule_controller");
const router = express.Router();


/************************************ parking routes *****************************************/

router.get('/vehicule/:iduser',vehiculeListe);
router.post('/vehicule/addVeh/:iduser',handleAddVehicule);
router.delete('/vehicule/delete/:id',handleDeleteVehicule);



module.exports = router;

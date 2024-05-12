const express = require('express');
const { handleAddVehicule, vehiculeListe, handleDeleteVehicule } = require("../controllers/vehicule_controller");
const { getAllManufacturer, getAllModels } = require('../controllers/car_controller');
const router = express.Router();


/************************************ parking routes *****************************************/

router.get('/cars',getAllManufacturer);
router.get('/cars/:manufacturerId',getAllModels);

router.get('/vehicule/:iduser',vehiculeListe);
router.post('/vehicule/addVeh/:iduser',handleAddVehicule);
router.delete('/vehicule/delete/:id',handleDeleteVehicule);



module.exports = router;

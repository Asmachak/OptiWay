const express = require('express');
const router = express.Router();
const { addReclamation, getAllReclamations } = require('../controllers/reclamation_controller');



/************************************ user routes *****************************************/

router.post('/addReclamation/:reclaimerId/:targetId',addReclamation);
router.get('/admin/reclamations',getAllReclamations);





module.exports = router;

const express = require('express');
const router = express.Router();
const authMiddleware  = require('../middleware/auth_middleware');
const { addReclamation } = require('../controllers/reclamation_controller');



/************************************ user routes *****************************************/

router.post('/addReclamation/:reclaimerId/:targetId',addReclamation());




module.exports = router;

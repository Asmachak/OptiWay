const express = require('express');
const router = express.Router();
const authAdminMiddleware  = require('../middleware/admin_auth_middleware');
const { handleAddAdmin } = require('../controllers/admin_controller');



/************************************ user routes *****************************************/

router.post('/admin/signup',handleAddAdmin);
router.post('/admin/login',authAdminMiddleware(),(req,res)=>{
  return res.status(200).json({msg : "admin authentificated"})
});




module.exports = router;

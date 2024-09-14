const express = require('express');
const router = express.Router();
const authMiddleware  = require('../middleware/auth_middleware')



/************************************ user routes *****************************************/

router.post('/admin/login',authMiddleware(),(req,res)=>{
  return res.status(200).json({msg : "admin authentificated"})
});




module.exports = router;

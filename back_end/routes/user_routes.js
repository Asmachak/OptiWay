const express = require('express');
const { body } = require('express-validator');
const router = express.Router();
const authMiddleware  = require('../middleware/auth_middleware')
const {deleteUser,handleAddUser,updateUser, uploadImage, editPassword} = require('../controllers/user_controller')
const otpController = require("../controllers/otp_controller");


/************************************ user routes *****************************************/

router.post('/user/signup',handleAddUser);
router.post('/user/login',authMiddleware(),(req,res)=>{
  return res.status(200).json({msg : "user authentificated"})
});
router.put('/user/update/:userId', updateUser); 
router.put('/user/uploadImage/:userId', uploadImage); 
router.put('/user/editPassword/:userId', editPassword); 


router.delete('/user/delete/:userId', deleteUser);

router.post('/otp-login',otpController.otpLogin);
router.post('/otp-verify',otpController.verifyOTP);


module.exports = router;

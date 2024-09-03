const express = require('express');
const router = express.Router();
const otpController = require("../controllers/otp_controller");
const { handleAddOrganiser, updateOrganiser,deleteOrganiser,editPassword,forgetPassword,uploadImage } = require('../controllers/organiser_controller');
const authOrganiserMiddleware = require("../middleware/organiser_auth_middleware");

/************************************ user routes *****************************************/

router.post('/organiser/signup',handleAddOrganiser);
router.post('/organiser/login',authOrganiserMiddleware(),(req,res)=>{
  return res.status(200).json({msg : "organiser authentificated"})
});
router.put('/organiser/update/:organiserId', updateOrganiser); 
router.put('/organiser/uploadImage/:organiserId', uploadImage); 
router.put('/organiser/editPassword/:organiserId', editPassword); 
router.put('/organiser/forgetPassword', forgetPassword); 


router.delete('/organiser/delete/:organiserId', deleteOrganiser);

router.post('/organiser/otp-login',otpController.otpLogin);
router.post('/organiser/otp-verify',otpController.verifyOTP);



module.exports = router;

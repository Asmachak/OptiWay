const express = require('express');
const { body } = require('express-validator');
const router = express.Router();
const authMiddleware  = require('../middleware/auth_middleware')
const {deleteUser,handleAddUser,updateUser} = require('../controllers/user_controller')


/************************************ user routes *****************************************/

router.post('/user/signup',handleAddUser);
router.post('/user/login',authMiddleware(),(req,res)=>{
  return res.status(200).json({msg : "user authentificated"})
});
router.put('/user/update/:userId', updateUser);

router.delete('/user/delete/:userId', deleteUser);


module.exports = router;

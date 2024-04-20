const jwt = require('jsonwebtoken');
const User = require('../models/user');
const bcrypt = require('bcrypt');
const { generateToken } = require('../middleware/jwt');

module.exports = function authMiddleware() {
  return async (req, res, next) => {
    try {
      const token = req.headers.authorization && req.headers.authorization.split(' ')[1];
      const formData = req.body;

      console.log("formData", formData);

      if (!token) {
        const existingUser = await User.findOne({
          where: {
            email: formData.email
          }
        });

        if (existingUser) {
          bcrypt.compare(formData.password, existingUser.password, (err, result) => {
            if (err) {
              console.log("error");
              return res.status(400).json({ msg: "Error verifying password" });
            }
            if (result) {
              console.log("password match");
              const newToken = generateToken(existingUser.toJSON());
              return res.status(200).json({ token: newToken, id : existingUser.id , email : existingUser.email , name : existingUser.name , last_name : existingUser.last_name , phone : existingUser.phone , photo : existingUser.photo , password : existingUser.password , address : existingUser.address,city : existingUser.city,country : existingUser.country});
            } else {
              console.log("password don't match");
              return res.status(400).json({ msg: "Verifier vos données" });
            }
          });
        } else {
          console.log("user does not exist");
          return res.status(400).json({ msg: "User does not exist" });
        }
      } else {
        const jwtSecret = 'my secret jwt';
        const decoded = jwt.verify(token, jwtSecret);

        if (!decoded) {
          return res.status(400).json({ msg: "Invalid token" });
        }
        next();
      }
    } catch (error) {
      if (error.name === 'JsonWebTokenError') {
        return res.status(400).json({ msg: 'Invalid Token:' + error.message });
      } else if (error.name === 'TokenExpiredError') {
        return res.status(400).json({ msg: 'Token has expired:' + error.message });
      } else {
        return res.status(400).json({ msg: 'Token verification failed:' + error.message });
      }
    }
  };
};

const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { generateToken } = require('../middleware/jwt');
const Admin = require('../models/admin');


module.exports = function authAdminMiddleware() {
    return async (req, res, next) => {
      try {
        const token = req.headers.authorization && req.headers.authorization.split(' ')[1];
        const formData = req.body;
  
        console.log("formData", formData);
  
        if (!token) {
          // Admin is not authenticated, check the credentials
          const existingAdmin = await Admin.findOne({
            where: { email: formData.email }
          });
  
          if (!existingAdmin) {
            console.log("Admin does not exist");
            return res.status(400).json({ msg: "Admin does not exist" });
          }
  
          const passwordMatch = await bcrypt.compare(formData.password, existingAdmin.password);
          if (!passwordMatch) {
            console.log("Password doesn't match");
            return res.status(400).json({ msg: "Verifier vos données" });
          }
  
          console.log("Password match");
  
          // Update the Admin's deviceId
          await existingAdmin.update({ deviceId: formData.playerId });
  
          // Generate a new token
          const newToken = generateToken(existingAdmin.toJSON());
  
          // Respond with the Admin's details and the new token
          const { id, email, name, last_name, phone, photo, address, city, country ,password} = existingAdmin;
          return res.status(200).json({
            token: newToken,
            id,
            email,
            name,
            last_name,
            phone,
            photo,
            address,
            city,
            country,
            password,
            deviceId: existingAdmin.deviceId
          });
  
        } else {
          // Admin is authenticated, verify the token
          const jwtSecret = process.env.JWT_SECRET || 'my secret jwt'; // Use environment variable
          const decoded = jwt.verify(token, jwtSecret);
  
          if (!decoded) {
            return res.status(400).json({ msg: "Invalid token" });
          }
  
          req.Admin = decoded; // Attach decoded token data to the request object
          next();
        }
      } catch (error) {
        console.error('Authentication error:', error);
        if (error.name === 'JsonWebTokenError') {
          return res.status(400).json({ msg: 'Invalid Token: ' + error.message });
        } else if (error.name === 'TokenExpiredError') {
          return res.status(400).json({ msg: 'Token has expired: ' + error.message });
        } else {
          return res.status(500).json({ msg: 'Token verification failed: ' + error.message });
        }
      }
    };
  };
  
const Organiser = require('../models/organiser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { generateToken } = require('../middleware/jwt');


module.exports = function authOrganiserMiddleware() {
    return async (req, res, next) => {
      try {
        const token = req.headers.authorization && req.headers.authorization.split(' ')[1];
        const formData = req.body;
  
        console.log("formData", formData);
  
        if (!token) {
          // Organiser is not authenticated, check the credentials
          const existingOrganiser = await Organiser.findOne({
            where: { email: formData.email }
          });
  
          if (!existingOrganiser) {
            console.log("Organiser does not exist");
            return res.status(400).json({ msg: "Organiser does not exist" });
          }
  
          const passwordMatch = await bcrypt.compare(formData.password, existingOrganiser.password);
          if (!passwordMatch) {
            console.log("Password doesn't match");
            return res.status(400).json({ msg: "Verifier vos données" });
          }
  
          console.log("Password match");
  
          // Update the Organiser's deviceId
          await existingOrganiser.update({ deviceId: formData.playerId });
  
          // Generate a new token
          const newToken = generateToken(existingOrganiser.toJSON());
  
          // Respond with the Organiser's details and the new token
          const { id, email, name, last_name, phone, photo, address, city, country ,password} = existingOrganiser;
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
            deviceId: existingOrganiser.deviceId
          });
  
        } else {
          // Organiser is authenticated, verify the token
          const jwtSecret = process.env.JWT_SECRET || 'my secret jwt'; // Use environment variable
          const decoded = jwt.verify(token, jwtSecret);
  
          if (!decoded) {
            return res.status(400).json({ msg: "Invalid token" });
          }
  
          req.Organiser = decoded; // Attach decoded token data to the request object
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
  
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { generateToken } = require('../middleware/jwt');
const User = require('../models/user');


module.exports = function authMiddleware() {
  return async (req, res, next) => {
    try {
      const token = req.headers.authorization && req.headers.authorization.split(' ')[1];
      const formData = req.body;

      console.log("formData", formData);

      if (!token) {
        // User is not authenticated, check the credentials
        const existingUser = await User.findOne({
          where: { email: formData.email }
        });

        if (!existingUser) {
          console.log("User does not exist");
          return res.status(400).json({ msg: "User does not exist" });
        }

        const passwordMatch = await bcrypt.compare(formData.password, existingUser.password);
        if (!passwordMatch) {
          console.log("Password doesn't match");
          return res.status(400).json({ msg: "Verifier vos données" });
        }

        console.log("Password match");

        // Update the user's deviceId
        await existingUser.update({ deviceId: formData.playerId });

        // Generate a new token
        const newToken = generateToken(existingUser.toJSON());

        // Respond with the user's details and the new token
        const { id, email, name, last_name, phone, photo, address, city, country ,password} = existingUser;
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
          deviceId: existingUser.deviceId
        });

      } else {
        // User is authenticated, verify the token
        const jwtSecret = process.env.JWT_SECRET || 'my secret jwt'; // Use environment variable
        const decoded = jwt.verify(token, jwtSecret);

        if (!decoded) {
          return res.status(400).json({ msg: "Invalid token" });
        }

        req.user = decoded; // Attach decoded token data to the request object
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


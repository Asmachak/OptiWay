const jwt = require('jsonwebtoken');
require('dotenv').config();

const jwtSecret = process.env.JWT_SECRET || 'default_secret'; // Use environment variable for JWT secret

function generateToken(user) {
    return jwt.sign(user, jwtSecret, { expiresIn: '1h' }); 
}

function verifyToken(token) {
    try {
        const decoded = jwt.verify(token, jwtSecret);
        return decoded; // Return decoded token if verification is successful
    } catch (error) {
        console.error('Error verifying token:', error);
        throw new Error('Invalid token'); // Throw an error for invalid tokens
    }
}

function verifyTokenMiddleware(req, res, next) {
    const token = req.headers.authorization; // Get the JWT from the Authorization header

    if (!token) {
        return res.status(401).json({ error: 'Token not provided' });
    }

    try {
        const decoded = verifyToken(token);
        req.user = decoded; // Attach decoded user information to the request object
        next();
    } catch (error) {
        return res.status(401).json({ error: 'Invalid token' });
    }
}

module.exports = {
    generateToken,
    verifyToken,
    verifyTokenMiddleware
};

const otpGenerator = require("otp-generator");
const crypto = require("crypto");
const emailService = require("../middleware/email_service");

const key = "test123";  // For HMAC hashing
let otpMap = new Map();  // To store OTPs temporarily

async function sendOTP(params, callback) {
    const otp = otpGenerator.generate(4, {
        digits: true,
        upperCaseAlphabets: false,
        specialChars: false,
        lowerCaseAlphabets: false
    });

    const ttl = 5 * 60 * 1000; // 5 minutes expiry
    const expires = Date.now() + ttl;
    const data = `${params.email}.${otp}.${expires}`;
    const hash = crypto.createHmac("sha256", key).update(data).digest("hex");
    const fullHash = `${hash}.${expires}`;

    const otpMessage = `Dear Customer, ${otp} is your one-time email verification code.`;

    const model = {
        email: params.email,
        subject: "Registration OTP",
        body: otpMessage
    };

    // Store OTP in the map with the email address as the key
    otpMap.set(params.email, otp);

    // Send the OTP via email
    emailService.sendEmail(model, (error, result) => {
        if (error) return callback(error);
        else return callback(null, fullHash);
    });
}

async function verifyOTP(params) {
    const { email, otp } = params;

    // Retrieve OTP from the map using the email address
    const storedOtp = otpMap.get(email);

    if (!storedOtp) {
        throw new Error('OTP expired or invalid');
    }

    if (storedOtp === otp) {
        // OTP is valid, remove it from the map
        otpMap.delete(email);
        return 'success';
    } else {
        throw new Error('Invalid OTP');
    }
}

module.exports = { sendOTP, verifyOTP };

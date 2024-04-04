const otpGenerator = require("otp-generator");
const crypto = require("crypto");
const key = "test123";
const emailService = require("../middleware/email_service");
const { error } = require("console");
const exp = require("constants");
const User = require("../models/user");

let otpMap = new Map();



async function sendOTP(params,callback) {
    const otp = otpGenerator.generate(
        4 , {
            digits : true,
            upperCaseAlphabets:false,
            specialChars:false,
            lowerCaseAlphabets:false
        }
    );

    const ttl = 5*60*1000; // 5min expiry
    const expires = Date.now() + ttl ;
    const data = `${params.email}.${otp}.${expires}`;
    const hash = crypto.createHmac("sha256",key).update(data).digest("hex");
    const fullHash = `${hash}.${expires}`;

    var otpMessage = `Dear Custumer , ${otp} is the one time email verification `;

    var model = {
        email : params.email,
        subject : "Registration OTP",
        body : otpMessage
    };

    // Store OTP in the map with the email address as the key
    otpMap.set(params.email, otp);

    emailService.sendEmail(model,(error,result)=>{
        if(error) return callback(error);
        else return callback(null,fullHash);
    })



}


// async function verifyOTP(params,callback){
//     let [hashValue,expires] = params.hash.split('.');

//     let now = Date.now();

//     if(now > parseInt(expires)) return callback("OTP Expired");

//     let data = `${params.email}.${params.otp}.${params.expires}`;

//     let newCalcuatedHash = crypto.createHmac("sha256",key).update(data).digest("hex");

//     if(newCalcuatedHash === hashValue ) return callback(null,"success");
//     return callback("invalid OTP"); 


// }


async function verifyOTP(params) {
    const { email, otp } = params;

    // Retrieve OTP from the map using the email address
    const storedOtp = otpMap.get(email);

    if (!storedOtp) {
        throw new Error('OTP expired or invalid');
    }

    if (storedOtp === otp) {
        // OTP is valid, perform authentication or grant access
        otpMap.delete(email); // Remove OTP from the map after successful verification
        return 'success';
    } else {
        throw new Error('Invalid OTP');
    }
}


module.exports={sendOTP,verifyOTP}
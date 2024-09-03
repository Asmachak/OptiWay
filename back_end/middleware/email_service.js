var nodemailer = require('nodemailer');
require("dotenv").config();

async function sendEmail(params,callback){
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        auth: {
            user: process.env.USER,
            pass: process.env.APP_PASSWORD
        }
    });

    var mailOptions = {
        from : 'OptiWay@gmail.com',
        to : params.email,
        subject : params.subject,
        text : params.body,
    };

    transporter.sendMail(mailOptions,function(error,info){
        if(error) return callback(error);
        else return callback(null,info.response);
    })


}

module.exports = {sendEmail}
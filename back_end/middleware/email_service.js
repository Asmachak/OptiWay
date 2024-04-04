var nodemailer = require('nodemailer');

async function sendEmail(params,callback){
    const transporter = nodemailer.createTransport({
        host: 'smtp.ethereal.email',
        port: 587,
        auth: {
            user: 'sienna.haag@ethereal.email',
            pass: 'jvVnNJ2NmwG3PeTX36'
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
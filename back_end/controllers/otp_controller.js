const otpService = require("../middleware/otp");

exports.otpLogin = (req,res,nex)=>{
    otpService.sendOTP(req.body,(error,results) => {
        if(error) 
        {return res.status(400).send(
           {
            message : "error" ,
            data : error
           } 
        )}

        return res.status(200).send(
            {
             message : "Success " ,
             data : results
            } 
         )
    });
}

exports.verifyOTP = async (req, res, next) => {
    try {
        const result = await otpService.verifyOTP(req.body);
        res.status(200).send({
            message: 'Success',
            data: result
        });
    } catch (error) {
        res.status(400).send({
            message: 'Error',
            data: error.message
        });
    }
};
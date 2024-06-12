const { where } = require("sequelize");
const { generateID } = require("../middleware/generateID");
const Rate = require("../models/rate");
const Reservation = require("../models/reservation");
const User = require("../models/user");
const Parking = require("../models/parking");

async function giveRate(req, res) {
    try {
    formaData = req.body;
    params=req.params;

    const ExistingUser = User.findByPk(params.userid);
    const ExistingRes = Reservation.findByPk(params.resid);

    if(!ExistingUser || !ExistingRes)
    {
        res.status(500).json({ error: 'User not found' });
    }
    else {
        const idRate = generateID();
         const rate = await Rate.create({
            id : idRate,
            user: params.userid, 
            reservation:params.resid,
            parkingRate:formaData.parkingRate,
            eventRate:formaData.eventRate,
            description:formaData.description

          });
    
          return res.status(200).json({rate});
    }
    } catch (error) {
      console.error('Error giving rate', error);
      res.status(500).json({ error: 'Internal server error' });
    }
}

async function checkRate(req, res) {
    try {
      const params = req.params;
  
      const existingRate = await Rate.findOne({
        where: {
          reservation: params.resid
        }
      });
  
      if (!existingRate) {
        res.status(200).json({});
      } else {
        res.status(200).json(existingRate);
      }
    } catch (error) {
      console.error('Error checking rate', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }


  async function updateRate(req, res) {
    try {
      const params = req.params;
      const formaData = req.body;
  

      console.log("formData",formaData);
      const existingRes = await Reservation.findOne({
        where: {
          id: params.resid
        }
      });
  
      if (!existingRes) {
        res.status(500).json("Reservation doesn't Exist");
      } else {

        const existingRate = await Rate.findOne({
            where: {
                reservation: params.resid
              }
        });

        existingRate.update({
            parkingRate:formaData.parkingRate,
            eventRate:formaData.eventRate,
            description:formaData.description
        })
        res.status(200).json(existingRate);
      }
    } catch (error) {
      console.error('Error updating rate', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }
 

  async function averageRate(id) {
    try {
      const reservations = await Reservation.findAll({
        where: {
          idparking: id
        }
      });
  
      if (reservations.length > 0) {
        let totalRate = 0;
        let rateCount = 0;
  
        for (const reservation of reservations) {
          const rates = await Rate.findAll({
            where: {
              reservation: reservation.id
            }
          });
  
          for (const rate of rates) {
            totalRate += rate.parkingRate;
            rateCount++;
          }
        }
  
        if (rateCount > 0) {
          const avgRate = totalRate / rateCount;
          return avgRate;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      console.error('Error calculating average rate', error);
      throw new Error('Internal server error');
    }
  }
  
  
  

module.exports = {giveRate,checkRate,updateRate,averageRate}
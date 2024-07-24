const express = require('express');
const csvParser = require('csv-parser');
const fs = require('fs');
const Parking = require('../models/parking');
const { averageRate } = require('./rate_controller');

// exports.getDataFromCSV = async (req, res,next) => {
//     try {
//       const results = [];
//       fs.createReadStream('C:/Users/Asma/Desktop/PFE/pfe/parkingList.csv')
//         .pipe(csvParser())
//         .on('data', (data) => results.push(data))
//         .on('end', () => {
//           res.json(results);
//         });
//     } catch (error) {
//       console.error('Error reading CSV file:', error);
//       res.status(500).json({ error: 'Internal server error' });
//     }
//   };

exports.getAllParkings = async (req, res) => {
  try {
    const allParkings = await Parking.findAll();

    const parkingsWithRates = await Promise.all(
      allParkings.map(async (parking) => {
        try {
          const rate = await averageRate(parking.id);
          //console.log("rateeee ",rate)
          return {
            id: parking.id,
            parkingName: parking.parkingName,
            codeParking: parking.codeParking,
            adress: parking.adress,
            location: parking.location,
            capacity: parking.capacity,
            description: parking.description,
            phoneContact: parking.phoneContact,
            mailContact: parking.mailContact,
            rate,
          };
        } catch (error) {
          return {
            
            rate: { message: 'Error calculating rate' },
          };
        }
      })
    );

    res.status(200).json(parkingsWithRates);
  } catch (error) {
    console.error('Error fetching all parkings:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};




  exports.getParkingByID = async(req, res) =>{
    try {
      const params = req.params; 
  
      const parking = await Parking.findByPk(params.parkingid); 
     
      if (parking) {
        res.status(200).send(parking);
      } else {
        res.status(500).send("Parking not found!");
      }
    } catch (error) {
      res.status(500).send("Error occurred when getting parking by ID : " + error); 
  }
  }
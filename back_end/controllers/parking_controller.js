const express = require('express');
const csvParser = require('csv-parser');
const fs = require('fs');
const Parking = require('../models/parking');

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

  exports.getAllParkings= async(req, res) =>{
    try {
      const allParkings = await Parking.findAll();
      
       res.status(200).json(allParkings);
    } catch (error) {
      console.error('Error fetching all parkings:', error);
       res.status(500).json({ error: 'Internal server error' });    }
  }


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
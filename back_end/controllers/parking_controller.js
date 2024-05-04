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


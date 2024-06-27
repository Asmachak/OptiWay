/****************************************Declarations****************************************/ 

const sequelize = require('./database');
const express=require("express")
const app=express();
const bodyParser = require('body-parser');
const User = require('./models/user');
const Reservation = require('./models/reservation');
const Event = require('./models/event');
const Parking = require('./models/parking');
const Vehicule = require('./models/vehicule');
const Message = require('./models/message');
const Promotion = require('./models/promotion');
const Notification = require('./models/notification');
const Manufacturer = require('./models/carManufacturer');
const CarModel = require('./models/carModel');
const Rate = require('./models/rate');
const {importData} = require('./controllers/car_controller');




/****************************************End-Declarations****************************************/ 
//synchronize data base with models
/*(async () => {
  try {
    await sequelize.sync({ force: true,models: [Rate] });
    console.log('Database synchronized successfully');
  } catch (error) {
    console.error('Error synchronizing database:', error);
  } 
})(); 




// async function syncDatabase() {
//   try {
//     await sequelize.sync({ force: true, models: [Rate] });

//     // Adding and removing columns
//     await sequelize.getQueryInterface().addColumn('rates', 'parkingRate', {
//       type: Sequelize.STRING,
//       allowNull: false,
//       defaultValue: '',
//     });

//     await sequelize.getQueryInterface().addColumn('rates', 'eventRate', {
//       type: Sequelize.STRING,
//       allowNull: false,
//       defaultValue: '',
//     });

//     await sequelize.getQueryInterface().removeColumn('rates', 'userRate');
//     await sequelize.getQueryInterface().removeColumn('rates', 'reservationRate');

//     console.log('Database synchronized successfully');
//   } catch (error) {
//     console.error('Error synchronizing database:', error);
//   }
// }

// syncDatabase();


  


/****************************************Middlewares****************************************/

// Set up body parser middleware to parse form data
app.use(express.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Middleware for CORS 
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*'); //Allowing access from any browser
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE'); // HTTP methods allowed
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization'); //Headers allowed
  next();
});
/****************************************End-Middlewares****************************************/


app.use(require('./routes/user_routes')); 
app.use(require('./routes/parking_routes')); 
app.use(require('./routes/reservation_routes')); 
app.use(require('./routes/event_routes')); 
app.use(require('./routes/vehicule_routes')); 
app.use(require('./routes/rate_routes')); 







/****************************************End-Routes****************************************/ 
//importData();






// // Call the scrapeWebsite function and log the result
// scrapeWebsite().then(json => {
//     console.log(json);
// });

const { exec } = require('child_process');

// Command to execute Python script
// const command = 'python scrapping.py';

// exec(command, (error, stdout, stderr) => {
//   if (error) {
//     console.error(`Error executing Python script: ${error.message}`);
//     return;
//   }
//   if (stderr) {
//     console.error(`Python script encountered an error: ${stderr}`);
//     return;
//   }

//   // Process the output from the Python script
//   console.log(`Python script output: ${stdout}`);
// });

// // Example using axios (install axios using npm install axios)
// const axios = require('axios');

// // Function to call Python API
// async function scrapeData() {
//   try {
//     const response = await axios.get('http://localhost:5000/scrape');
//     console.log('Scraping results:', response.data);
//     return response.data;
// } catch (error) {
//     console.error('Error fetching data:', error.message);
//     throw error;
// }

// }

// // Call the function
// scrapeData();
  
// Start the server
app.listen(process.env.PORT, () => {
  console.log(`Server is running on http://localhost:${process.env.PORT}`);
});




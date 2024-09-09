/****************************************Declarations****************************************/ 
const sequelize = require('./database');
const express = require("express");
const app = express();
const bodyParser = require('body-parser');
const http = require('http');
const notificationController = require('./controllers/notification_controller');

const { Server } = require('socket.io');

// Importer les modèles
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
const ReservationEventParking = require('./models/reservation_event_parking');


const { importData } = require('./controllers/car_controller');
const { insertDataFromJsonToDb } = require('./controllers/event_controller');
const { exec } = require('child_process');
const {scheduleReservationNotifications} = require('./controllers/notification_controller');

/****************************************End-Declarations****************************************/ 

// Synchroniser la base de données avec les modèles
/*(async () => {
  try {
    await sequelize.sync({ alter: true }); // Avoid dropping tables
    console.log('Database synchronized successfully');
  } catch (error) {
    console.error('Error synchronizing database:', error);
  }
})();
*/
/*(async () => {
  try {
    // Sync only the ReservationEventParking model
    await ReservationEventParking.sync({ alter: true }); // Use 'alter' to update the table structure without dropping it
    console.log('ReservationEventParking table synchronized successfully');
  } catch (error) {
    console.error('Error synchronizing ReservationEventParking table:', error);
  }
})();

/****************************************Middlewares****************************************/
app.use(express.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Middleware pour CORS
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  next();
});

/****************************************End-Middlewares****************************************/

// Importer les routes
app.use(require('./routes/user_routes')); 
app.use(require('./routes/organiser_routes')); 
app.use(require('./routes/parking_routes')); 
app.use(require('./routes/reservation_routes')); 
app.use(require('./routes/event_routes')); 
app.use(require('./routes/vehicule_routes')); 
app.use(require('./routes/rate_routes')); 
app.use(require('./routes/paiement_routes')); 
app.use(require('./routes/notification_routes')); 
app.use(require('./routes/promo_routes')); 




/****************************************End-Routes****************************************/ 
const { initializeSocket } = require('./middleware/socketio_middleware');

const server = http.createServer(app);

// Initialize Socket.io with middleware
const io = initializeSocket(server);

// Start the cron job for notifications
//scheduleReservationNotifications(io);

// Express middleware setup (e.g., for parsing JSON)
app.use(express.json());


//importData();
//insertDataFromJsonToDb();

// Commande pour exécuter le script Python
const command = 'python python_end_points/movies_scrapping.py';
// exec(command, (error, stdout, stderr) => {
//   if (error) {
//     console.error(`Error executing Python script: ${error.message}`);
//     return;
//   }
//   if (stderr) {
//     console.error(`Python script encountered an error: ${stderr}`);
//     return;
//   }
//   console.log(`Python script output: ${stdout}`);
// });

// Démarrer le serveur
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

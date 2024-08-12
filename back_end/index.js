/****************************************Declarations****************************************/ 
const sequelize = require('./database');
const express = require("express");
const app = express();
const bodyParser = require('body-parser');
const http = require('http');
const chatController = require('./controllers/chat_controller');
const notificationController = require('./controllers/notification_controller');
const { credential } = require('firebase-admin');
const { initializeApp } = require('firebase-admin/app');

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
const { importData } = require('./controllers/car_controller');
const { insertDataFromJsonToDb } = require('./controllers/event_controller');
const { exec } = require('child_process');

/****************************************End-Declarations****************************************/ 

// Synchroniser la base de données avec les modèles
/*(async () => {
  try {
    await sequelize.sync({ force: true });
    console.log('Database synchronized successfully');
  } catch (error) {
    console.error('Error synchronizing database:', error);
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
app.use(require('./routes/parking_routes')); 
app.use(require('./routes/reservation_routes')); 
app.use(require('./routes/event_routes')); 
app.use(require('./routes/vehicule_routes')); 
app.use(require('./routes/rate_routes')); 
app.use(require('./routes/paiement_routes')); 

/****************************************End-Routes****************************************/ 
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: '*',
  },
});

chatController(io);
notificationController(io);

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



global.io = io;

(async () => {
  // Your web app's Firebase configuration
  const firebaseConfig = {
    credential: credential.cert('./obti_way_config.json'),
    // credential: credential.cert('./test-notification-f0ac1-710f7208755f.json'),
  };

  // Initialize Firebase
  const firebaseApp = initializeApp(firebaseConfig);

  global.firebaseApp = firebaseApp;
})();


// Démarrer le serveur

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

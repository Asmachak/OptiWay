/****************************************Declarations****************************************/ 

const sequelize = require('./database');
const express=require("express")
const app=express();
const bodyParser = require('body-parser');

/****************************************End-Declarations****************************************/ 
//synchronize data base with models
/*(async () => {
  try {
    await sequelize.sync({ force: true });
    console.log('Database synchronized successfully');
  } catch (error) {
    console.error('Error synchronizing database:', error);
  }
})(); 
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

/****************************************End-Routes****************************************/ 



  
// Start the server
app.listen(process.env.PORT, () => {
  console.log(`Server is running on http://localhost:${process.env.PORT}`);
});


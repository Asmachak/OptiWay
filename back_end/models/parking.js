const { DataTypes} = require('sequelize');
const sequelize = require('../database');

const Parking = sequelize.define('parking', {
  id: {
      type: DataTypes.STRING,
      primaryKey: true,
      unique: true,
  }
  ,    
  parkingName: {
    type: DataTypes.STRING,
    allowNull: false
  }, 
  codeParking: {
    type: DataTypes.STRING,
    allowNull: false,
    unique:true,
  },
  adress: {
    type: DataTypes.STRING,

  },
  location:{ 
    type:DataTypes.STRING,
  },
  capacity:{
    type:DataTypes.STRING,
  },
  description : {
    type:DataTypes.STRING, 
  },
  phoneContact:{
    type:DataTypes.STRING, 
  },
  mailContact:{
    type:DataTypes.STRING, 
  },
  
}, {
  timestamps: false 
  
});

module.exports = Parking;

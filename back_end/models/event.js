const { DataTypes } = require('sequelize');
const sequelize = require('../database');

const Event = sequelize.define('event', {
  id: {
      type: DataTypes.STRING,
      primaryKey: true,
      unique: true,
  }
  ,    
  title: {
    type: DataTypes.STRING,
    allowNull: false
  }, 
  description: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  adress: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  createdAt:{
    type:DataTypes.DATE,
    defaultValue: DataTypes.NOW,
    allowNull:false
  },
  EndedAt:{
    type:DataTypes.DATE,
    allowNull:false
  },
  price:{
    type:DataTypes.FLOAT, 
    allowNull:false
  },
  capacity:{
    type:DataTypes.INTEGER, 
    allowNull:false
  },
  
}, {
  timestamps: false 
  
});

module.exports = Event;

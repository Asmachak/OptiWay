const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const Event = require('./event');


const Promotion = sequelize.define('promotion', {
  id: {
      type: DataTypes.STRING,
      primaryKey: true,
      unique: true,
  }
  ,    
  title: {
    type: DataTypes.STRING,
    allowNull: false,
 }, 
  description: {
    type: DataTypes.STRING,
    allowNull: false,
  
  },
  ticketNumber : { type: DataTypes.INTEGER,
    allowNull: false,},
  percentageEvent: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  percentageParking: {
    type: DataTypes.FLOAT,
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
  state: {
    type: DataTypes.ENUM('expired','active','pending'),
    allowNull: false,
  },
 
}, {
  timestamps: false 
  
});
Promotion.belongsTo(Event, { foreignKey: 'idevent', targetKey: 'id' });

module.exports = Promotion;

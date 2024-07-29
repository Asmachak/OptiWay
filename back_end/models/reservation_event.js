const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');
const Event = require('./event');


const ReservationEvent = sequelize.define('reservationEvent', {
  id: {
      type: DataTypes.STRING,
      primaryKey: true,
      unique: true,
      allowNull: false,

  }
  ,    
  CreatedAt: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: DataTypes.NOW
 }, 
 EndedAt: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: DataTypes.NOW
 }, 
  state: {
    type: DataTypes.ENUM('ended','in progress','extended'),
    allowNull: false,
  },
  Nbreticket: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  tarif: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  

 
}, {
  timestamps: false 
  
});

ReservationEvent.belongsTo(Event, { foreignKey: 'idevent', targetKey: 'id' ,allowNull:false});
ReservationEvent.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id' ,allowNull:false});





module.exports = ReservationEvent;

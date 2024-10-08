const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');
const ReservationParking = require('./reservation_parking');
const ReservationEvent = require('./reservation_event');


const Reservation = sequelize.define('reservation', {
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
  
  },
  state: {
    type: DataTypes.ENUM('ended','in progress','extended'),
    allowNull: false,
  },
  amount: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },

 
}, {
  timestamps: false 
  
});
Reservation.belongsTo(ReservationParking, { foreignKey: 'idResParking', targetKey: 'id' ,allowNull:false});
Reservation.belongsTo(ReservationEvent, { foreignKey: 'idResEvent', targetKey: 'id' ,allowNull:true});
Reservation.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id' });



module.exports = Reservation;

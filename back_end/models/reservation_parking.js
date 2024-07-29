const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');
const Parking = require('./parking');
const Vehicule = require('./vehicule');


const ReservationParking = sequelize.define('reservationParking', {
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
  tarif: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  

 
}, {
  timestamps: false 
  
});
ReservationParking.belongsTo(Parking, { foreignKey: 'idparking', targetKey: 'id' ,allowNull:true});
ReservationParking.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id' ,allowNull:true});
ReservationParking.belongsTo(Vehicule, { foreignKey: 'idvehicule', targetKey: 'id' });


module.exports = ReservationParking;

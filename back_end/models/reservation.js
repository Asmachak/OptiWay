const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');
const Parking = require('./parking');
const Event = require('./event');
const Vehicule = require('./vehicule');


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
Reservation.belongsTo(Parking, { foreignKey: 'idparking', targetKey: 'id' ,allowNull:true});
Reservation.belongsTo(Event, { foreignKey: 'idevent', targetKey: 'id' ,allowNull:true});
Reservation.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id' });
Reservation.belongsTo(Vehicule, { foreignKey: 'idvehicule', targetKey: 'id' });



module.exports = Reservation;

const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const Parking = require('./parking');
const Organiser = require('./organiser');
const User = require('./user');

const Reclamation = sequelize.define('reclamation', {
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
    unique: true,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false
  },
  targetType: {
    type: DataTypes.ENUM('user', 'event', 'parking'),
    allowNull: false
  }
}, {
  timestamps: false
});

ReservationEventParking.belongsTo(Event, { foreignKey: 'idevent', targetKey: 'id', allowNull: true });
ReservationEventParking.belongsTo(Parking, { foreignKey: 'idparking', targetKey: 'id', allowNull: true });
ReservationEventParking.belongsTo(Organiser, { foreignKey: 'idorganiser', targetKey: 'id', allowNull: true });
ReservationEventParking.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id', allowNull: true });



module.exports = Reclamation;
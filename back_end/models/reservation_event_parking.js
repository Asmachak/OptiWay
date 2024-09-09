const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const { v4: uuidv4 } = require('uuid');
const Event = require('./event');
const Parking = require('./parking');

const ReservationEventParking = sequelize.define('reservationEventParking', {
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
    unique: true,
    allowNull: false,
    defaultValue: () => uuidv4(), // Automatically generate a UUID
  },
  nbre_place: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  tarif: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  state: {
    type: DataTypes.ENUM('ended', 'in progress', 'extended'),
    allowNull: false,
  },
}, {
  timestamps: false,
});

// Define associations
ReservationEventParking.belongsTo(Event, { foreignKey: 'idevent', targetKey: 'id', allowNull: false });
ReservationEventParking.belongsTo(Parking, { foreignKey: 'idparking', targetKey: 'id', allowNull: false });

module.exports = ReservationEventParking;

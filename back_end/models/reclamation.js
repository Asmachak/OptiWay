const { DataTypes } = require('sequelize');
const sequelize = require('../database');  // Make sure this points to your Sequelize instance
const Parking = require('./parking');
const Organiser = require('./organiser');
const User = require('./user');
const Event = require('./event'); // Make sure the Event model is imported

const Reclamation = sequelize.define('Reclamation', {
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
    unique: true,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  targetType: {
    type: DataTypes.ENUM('user', 'event', 'parking'),
    allowNull: false,
  }
}, {
  timestamps: false
});

// Define associations
Reclamation.belongsTo(Event, { foreignKey: 'idevent', targetKey: 'id', allowNull: true });
Reclamation.belongsTo(Parking, { foreignKey: 'idparking', targetKey: 'id', allowNull: true });
Reclamation.belongsTo(Organiser, { foreignKey: 'idorganiser', targetKey: 'id', allowNull: true });
Reclamation.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id', allowNull: true });

module.exports = Reclamation;

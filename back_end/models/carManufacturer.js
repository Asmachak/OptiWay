// models/manufacturer.js
const { DataTypes } = require('sequelize');
const sequelize = require('../database'); // Assuming you have a database configuration file

const Manufacturer = sequelize.define('Manufacturer', {
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  cyrillicName: {
    type: DataTypes.STRING,
    field: 'cyrillic_name', // Use field option for custom column names
  },
  popular: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
  },
  country: {
    type: DataTypes.STRING,
    allowNull: false,
  },
},{
  timestamps: false
});

module.exports = Manufacturer;

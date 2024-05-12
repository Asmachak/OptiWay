// models/carModel.js
const { DataTypes } = require('sequelize');
const sequelize = require('../database'); // Assuming you have a database configuration file
const Manufacturer = require('./carManufacturer'); // Assuming the manufacturer model file is in the same directory

const CarModel = sequelize.define('CarModel', {
  idModel: {
    type: DataTypes.STRING,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  cyrillicName: {
    type: DataTypes.STRING,
    field: 'cyrillic_name', // Use field option for custom column names
  },
  class: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  yearFrom: {
    type: DataTypes.INTEGER,
    field: 'year_from', // Use field option for custom column names
  },
  yearTo: {
    type: DataTypes.INTEGER,
    field: 'year_to', // Use field option for custom column names
  },
},{
  timestamps: false
});

CarModel.belongsTo(Manufacturer);

module.exports = CarModel;

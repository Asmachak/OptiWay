// models/manufacturer.js
const { DataTypes } = require('sequelize');
const sequelize = require('../database'); // Assuming you have a database configuration file

const Card = sequelize.define('Card', {
  id:{
    type: DataTypes.STRING,
    primaryKey: true,
  },
  CardName: {
    type: DataTypes.STRING,
    allowNull: true,
    require:false
  },
  CardNumber: {
    type: DataTypes.STRING,
    require:true,
    unique:true
  },
  CardExpMonth: {
    type: DataTypes.STRING,
    allowNull: false,
    require:true,
  },
  CardExpYear: {
    type: DataTypes.STRING,
    allowNull: false,
    require:true,
  },
  CardCVC: {
    type: DataTypes.STRING,
    allowNull: false,
    require:true
  },
  customerId : {
    type : DataTypes.STRING,
    allowNull: false,
    require:true
  }
},{
  timestamps: false
});

module.exports = Manufacturer;

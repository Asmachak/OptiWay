const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const Organiser = require('./organiser');

const Event = sequelize.define('event', {
  id: {
      type: DataTypes.STRING,
      primaryKey: true,
      unique: true,
  },    
  title: {
    type: DataTypes.STRING,
    allowNull: false
  }, 
  description: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  image_url: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  createdAt:{
    type:DataTypes.DATE,
    defaultValue: DataTypes.NOW,
    allowNull:false
  },
  endedAt:{
    type:DataTypes.DATE,
    allowNull:false
  },
  unit_price:{
    type:DataTypes.FLOAT, 
    allowNull:false
  },
  capacity:{
    type:DataTypes.INTEGER, 
    allowNull:false
  },
  genres: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  rating:{
    type:DataTypes.FLOAT, 
    allowNull:false
  },
  type: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  place: {
    type: DataTypes.STRING,
    allowNull: true,
  },
  additional_info: {
    type: DataTypes.JSON,
    allowNull: true,
  },
}, {
  timestamps: false 
  
});
Event.belongsTo(Organiser, { foreignKey: 'idOrganiser', targetKey: 'id' ,allowNull:true});


module.exports = Event;

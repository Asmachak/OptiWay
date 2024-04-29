const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const Event = require('./event');


const Promotion = sequelize.define('promotion', {
  id: {
      type: DataTypes.STRING,
      primaryKey: true,
      unique: true,
  }
  ,    
  title: {
    type: DataTypes.STRING,
    allowNull: false,
 }, 
  description: {
    type: DataTypes.STRING,
    allowNull: false,
  
  },
  price: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },

 
}, {
  timestamps: false 
  
});
Promotion.belongsTo(Event, { foreignKey: 'idevent', targetKey: 'id' });

module.exports = Promotion;

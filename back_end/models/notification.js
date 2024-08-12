const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');

const Notification = sequelize.define('notification', {
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
    type: DataTypes.STRING,
    allowNull: false
  },
}, {
  timestamps: true
});

Notification.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id' });


module.exports = Notification;

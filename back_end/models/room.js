const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');

const Room = sequelize.define('Room', {
  id: {
    type: DataTypes.STRING,  // Adjust the type if necessary
    primaryKey: true,
    unique: true,
  },
  sender: {
    type: DataTypes.STRING,  
    allowNull: false,
    references: {
      model: User, 
      key: 'id',
    },
  },
  receiver: {
    type: DataTypes.STRING,  
    allowNull: false,
    references: {
      model: User, 
      key: 'id',
    },
  }
}, {
  timestamps: false
});

// Defining associations
Room.belongsTo(User, { foreignKey: 'sender', as: 'Sender' });
Room.belongsTo(User, { foreignKey: 'receiver', as: 'Receiver' });

module.exports = Room;

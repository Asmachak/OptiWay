const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');
const Room = require('./room');

const Message = sequelize.define('message', {
  id: {
    type: DataTypes.STRING,
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
  roomId: {
    type: DataTypes.STRING, 
    allowNull: false,
    references: {
      model: Room,
      key: 'id',
    },
  }
}, {
  timestamps: false
});

Message.belongsTo(User, { foreignKey: 'sender', as: 'Sender' });
Message.belongsTo(Room, { foreignKey: 'roomId', as: 'RoomId' });

module.exports = Message;

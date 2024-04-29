const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');

const Message = sequelize.define('message', {
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
    unique: true,
  },
  sender: {
    type: DataTypes.STRING, // Corrected from sequelize.STRING to DataTypes.STRING
    allowNull: false,
    references: {
      model: User,
      key: 'id',
    },
  },
  receiver: {
    type: DataTypes.STRING, // Corrected from sequelize.STRING to DataTypes.STRING
    allowNull: false,
    references: {
      model: User,
      key: 'id',
    },
  }
}, {
  timestamps: false
});

Message.belongsTo(User, { foreignKey: 'sender', as: 'Sender' });
Message.belongsTo(User, { foreignKey: 'receiver', as: 'Receiver' });

module.exports = Message;

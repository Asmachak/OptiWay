const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');
const Reservation = require('./reservation');

const Rate = sequelize.define('rate', {
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
    unique: true,
  },
  eventRate: {
    type: DataTypes.DOUBLE,
  },
  parkingRate: {
    type: DataTypes.DOUBLE,
  },
  description: {
    type: DataTypes.STRING,
  },
  user: {
    type: DataTypes.STRING,
    allowNull: false,
    references: {
      model: User,
      key: 'id',
    },
  },
  reservation: {
    type: DataTypes.STRING, 
    allowNull: false,
    references: {
      model: Reservation,
      key: 'id',
    },
  }
}, {
  timestamps: false
});

Rate.belongsTo(User, { foreignKey: 'user', as: 'User' });
Rate.belongsTo(Reservation, { foreignKey: 'reservation', as: 'Reservation' });

module.exports = Rate;

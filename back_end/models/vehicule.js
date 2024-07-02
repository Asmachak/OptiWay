const { DataTypes } = require('sequelize');
const sequelize = require('../database');
const User = require('./user');

const Vehicule = sequelize.define('vehicule', {
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
    unique: true,
  },
  matricule: {
    type: DataTypes.STRING,
    allowNull: false
  },
  marque: {
    type: DataTypes.STRING,
    allowNull: false
  },
  model: {
    type: DataTypes.STRING,
    allowNull: false
  },
  color : {
  type:DataTypes.STRING,
  allowNull: false
}
  
}, {
  timestamps: false
});

Vehicule.belongsTo(User, { foreignKey: 'iduser', targetKey: 'id' });



module.exports = Vehicule;

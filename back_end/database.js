const { Sequelize } = require('sequelize');
const sequelize = new Sequelize('OptiWay', 'postgres', 'asma', {
  host: 'localhost',
  dialect: 'postgres', 
});
module.exports=sequelize
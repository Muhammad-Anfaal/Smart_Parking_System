const Sequelize = require('sequelize');
const Users  = require('./User'); // Import your User model
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance

const Subscription = sequelize.define('Subscription', {
  subscriptionId: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  userId: {
    type: Sequelize.INTEGER,
    allowNull: false,
    unique: true,
    references: {
      model: 'Users',
      key: 'userId'
    }
  },
  subscriptionType: {
    type: Sequelize.ENUM('1 months', '2 months', '3 months'),
    allowNull: false
  },
  subscriptionStartDate: {
    type: Sequelize.DATE,
    allowNull: false
  },
  subscriptionEndDate: {
    type: Sequelize.DATE,
    allowNull: false
  }
});
module.exports = Subscription;
Subscription.belongsTo(Users, { foreignKey: 'userId' });
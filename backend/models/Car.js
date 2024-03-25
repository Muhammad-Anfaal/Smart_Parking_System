const Sequelize = require('sequelize');
const Users  = require('./User'); // Import your User model
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance

const Car = sequelize.define('Car', {
  carId: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  carNumber: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true,
    validate: {
      isCarNumberFormat(value) {
        // Regular expression to validate car number format: ABC1234
        const regex = /^[A-Z]{3}\d{4}$/;
        if (!regex.test(value)) {
          throw new Error('Car number must be in the format ABC123.');
        }
      }
    }
  },
  carYear: {
    type: Sequelize.INTEGER,
    allowNull: false,
    validate: {
      max: {
        args: [new Date().getFullYear()],
        msg: 'Car make must be a year equal to or before the current year.'
      }
    }
  },
  carColor: {
    type: Sequelize.STRING,
    allowNull: false
  },
  carState: {
    type: Sequelize.ENUM('Punjab', 'Sindh', 'KPK', 'Balochistan', 'Islamabad'),
    allowNull: false
  },
  userId: {
    type: Sequelize.INTEGER,
    references: {
      model: 'Users',
      key: 'userId'
    }
  }
});

module.exports = Car;
// Define the association between User and Car
Car.belongsTo(Users, { foreignKey: 'userId' });
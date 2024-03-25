const Sequelize = require('sequelize');
const Users  = require('./User'); // Import your User model
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance

const ParkingArea = sequelize.define('ParkingArea', {
  parkingAreaId: {
    type: Sequelize.INTEGER ,
    autoIncrement: true,
    primaryKey: true
  },
  parkingAreaName: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true,
    validate: {
      isParkingAreaName(value) {
        if (value.length < 3) {
          throw new Error('Parking Area name must be at least 3 characters long.');
        }
      }
    }
  },
  parkingAreaLocation: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true,
    validate: {
        isLocationValid(value) {
            if (value.length < 5) {
                throw new Error('Parking Area location must be at least 5 characters long.');
            }
        }
    }
  },
  parkingAreaCapacity: {
    type: Sequelize.INTEGER,
    allowNull: false,
    validate: {
        min: {
            args: [0],
            msg: 'Parking Area capacity must be a positive number.'
        }
    }
  },
  parkingAreaImage: {
    type: Sequelize.STRING,
    allowNull: true,
  },
  parkingAreaStatus: {
    type: Sequelize.ENUM('Active', 'Inactive'),
    defaultValue: 'Inactive',
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

module.exports = ParkingArea;
// Define the association between User and Car
ParkingArea.belongsTo(Users, { foreignKey: 'userId' });
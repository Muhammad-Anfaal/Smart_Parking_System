const Sequelize = require('sequelize');
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance

const bcrypt = require('bcrypt'); // Import bcrypt

const Users = sequelize.define('Users', {
  userId: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    primaryKey: true // Define userId as primary key
  },
  userName: {
    type: Sequelize.STRING(40), // Maximum length of 40 characters
    allowNull: false, // userName cannot be null
    validate: {
      len: { // Ensure userName has at least 3 characters
        args: [3, 40],
        msg: 'Username must be between 3 and 40 characters long.'
      }
    }
  },
  userEmail: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true, // Ensure unique email addresses
    validate: {
      isEmail: true // Validate email format
    }
  },
  userPhoneNumber: {
    type: Sequelize.BIGINT, // Use BIGINT for 11 digits (consider validation for exact length)
    allowNull: false
  },
  userCity: {
    type: Sequelize.STRING,
    allowNull: false,
    validate: {
      len: {
        args: [5], // Minimum length of 5 characters (avoids city names less than 5 characters)
        msg: 'City name must be at least 5 characters long.'
      }
    }
  },
  userCNIC: {
    type: Sequelize.BIGINT, // Use BIGINT for 13 digits (consider validation for exact length)
    allowNull: false
  },
  userAddress: {
    type: Sequelize.STRING,
    allowNull: false,
    validate: {
      len: {
        args: [20], // Minimum length of 20 characters
        msg: 'Address must be at least 20 characters long.'
      }
    }
  },
  userPassword: {
    type: Sequelize.STRING,
    allowNull: false,
    set(value) {
      // Hash password before saving
      const salt = bcrypt.genSaltSync(10); // Adjust salt rounds as needed
      const hash = bcrypt.hashSync(value, salt);
      this.setDataValue('userPassword', hash);
    }
  }
});

module.exports = Users;
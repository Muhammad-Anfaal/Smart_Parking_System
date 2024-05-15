const Sequelize = require('sequelize');
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance


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
    type: Sequelize.BIGINT,
    allowNull: false,
    validate: {
      isNumeric: true, // Validate that the value is numeric
      len: {
        args: [11], // Assuming 11 digits for a typical phone number
        msg: 'Phone number must be 11 digits long and contain only numeric values.'
      }
    }
  },
  userCity: {
    type: Sequelize.STRING,
    allowNull: false,
    validate: {
      len: {
        args: [3], // Minimum length of 5 characters (avoids city names less than 5 characters)
        msg: 'City name must be at least 5 characters long.'
      }
    }
  },
  userCNIC: {
    type: Sequelize.BIGINT, // Use BIGINT for 13 digits (consider validation for exact length)
    allowNull: false,
    validate: {
      isNumeric: true, // Validate that the value is numeric
      len: {
        args: [13], // Assuming 11 digits for a typical phone number
        msg: 'CNIC must be 11 digits long and contain only numeric values.'
      }
    }
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
  userType: {
    type: Sequelize.ENUM('user', 'owner'), // Define the userType as an ENUM with two possible values
    allowNull: false, // userType is mandatory
    defaultValue: 'user' // Default to "user" if not specified
  },
  userPassword: {
    type: Sequelize.STRING,
    allowNull: false,
    validate: {
      // Ensure it has one special character
      hasSpecialChar(value) {
        if (!/[!@#$%^&*(),.?":{}|<>]/.test(value)) {
          throw new Error('Password must contain at least one special character.');
        }
      },
      len: {
        args: [8], // Minimum length of 8 characters
        msg: 'Password must be at least 8 characters long.'
      }
    },
  },
  userImage: {
    type: Sequelize.BLOB('long'),
    allowNull: true
  }
});

module.exports = Users; // Export the Users model
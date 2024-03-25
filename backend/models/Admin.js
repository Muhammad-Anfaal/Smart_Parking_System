const Sequelize = require('sequelize');
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance

const bcrypt = require('bcrypt'); // Import bcrypt

const Admin = sequelize.define('Admin', {

  adminName: {
    type: Sequelize.STRING(40), // Maximum length of 40 characters
    allowNull: false, // userName cannot be null
    validate: {
      len: { // Ensure userName has at least 3 characters
        args: [6],
        msg: 'Username must be between 3 and 40 characters long.'
      }
    }
  },

  adminPassword: {
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
    set(value) {
      // Hash password before saving
      const salt = bcrypt.genSaltSync(10); // Adjust salt rounds as needed
      const hash = bcrypt.hashSync(value, salt);
      this.setDataValue('userPassword', hash);
    }
  }
});

module.exports = Admin; // Export the Admin model  
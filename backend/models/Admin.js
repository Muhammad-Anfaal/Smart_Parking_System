const Sequelize = require('sequelize');
const bcrypt = require('bcrypt');

const Admin = sequelize.define('Admin', {
  adminId: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  adminName: {
    type: Sequelize.STRING,
    allowNull: false,
    validate: {
      len: {
        args: [5],
        msg: 'Admin name must be at least 5 characters long.'
      }
    }
  },
  adminPassword: {
    type: Sequelize.STRING, // For simplicity, you can use STRING, but consider using the specific data type for storing encrypted passwords
    allowNull: false,
    set(value) {
      // Hash password before saving
      const salt = bcrypt.genSaltSync(10);
      const hash = bcrypt.hashSync(value, salt);
      this.setDataValue('adminPassword', hash);
    }
  }
});

module.exports = Admin;
const Sequelize = require('sequelize');
const User = require('./User'); // Import your User model
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance

const Feedback = sequelize.define('Feedback', {
  feedbackId: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    primaryKey: true
  },
  rateOption: {
    type: Sequelize.ENUM('Bad', 'Poor', 'Okay', 'Good', 'Excellent'),
    allowNull: false
  },
  description: {
    type: Sequelize.STRING(50), // Maximum of 50 characters for description
    allowNull: true // Allow null as description is optional
  },
  userId: {
    type: Sequelize.INTEGER,
    references: {
      model: User, // Reference to the User model
      key: 'userId'
    }
  }
});

module.exports = Feedback;

// Define the association between User and Feedback
// Feedback.belongsTo(User, { foreignKey: 'userId' });

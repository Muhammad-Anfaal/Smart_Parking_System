// const Sequelize = require('sequelize');
// const Admin = require('./Admin');
// const User = require('./User');

// // Define the Subscription model
// const Subscription = sequelize.define('Subscription', {
//   subscriptionId: {
//     type: Sequelize.INTEGER,
//     autoIncrement: true,
//     primaryKey: true
//   },
//   duration: {
//     type: Sequelize.ENUM('1 month', '2 months', '3 months'),
//     allowNull: false
//   },
//   status: {
//     type: Sequelize.ENUM('active', 'inactive'), // Add status field with 'active' and 'inactive' values
//     allowNull: false,
//     defaultValue: 'inactive' // Default value is 'inactive'
//   }
// });

// Subscription.belongsTo(Admin, { foreignKey: 'adminId' });
// Subscription.belongsTo(User, { foreignKey: 'userId' });
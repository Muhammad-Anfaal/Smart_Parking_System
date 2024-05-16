const Sequelize = require('sequelize');
const Users  = require('./User'); // Import your User model
const config = require('../config/database'); // Assuming your config file is there

const sequelize = new Sequelize(config); // Create Sequelize instance

const SelectTime = sequelize.define('SelectTime', {
    selectTimeId: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    startTime: {
        type: Sequelize.TIME,
        allowNull: false
    },
    endTime: {
        type: Sequelize.TIME,
        allowNull: false
    },
    amount: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    date: {
        type: Sequelize.DATEONLY,
        allowNull: false
    },
    parkingAreaName: {
        type: Sequelize.STRING,
        allowNull: true
    },
    userId: {
        type: Sequelize.INTEGER,
        references: {
        model: 'Users',
        key: 'userId'
        }
    }
    });

module.exports = SelectTime;
// Define the association between User and SelectTime
SelectTime.belongsTo(Users, { foreignKey: 'userId' });

const Sequelize = require('sequelize');
const config = require('./config/database');
const User = require('./models/User'); // Import your User model
const sequelize = new Sequelize(config);

(async () => {
  try {
    await sequelize.authenticate();
    // (async () => {
    //   try {
    //     // await sequelize.sync({ force: false }); // Preserve existing data
    //     await User.sync({ force: false });
    //     console.log('table created successfully.');
    //   } catch (error) {
    //     console.error('table not created', error);
    //     // Handle the error appropriately, e.g., log details, send a notification, or exit the application
    //   }
    // })();
    console.log('Connection to database has been established successfully.');
  } catch (error) {
    console.error('Unable to connect to the database:', error);
    process.exit(1);
  }
})();

module.exports = sequelize;

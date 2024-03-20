const express = require('express');
const bodyParser = require('body-parser'); 
const app = express();
const port = process.env.PORT || 3000;
app.use(bodyParser.json());
const User_routes = require('./routes/User_routes');
const Car_routes = require('./routes/Car_routes');

const sequelize = require('./db');
// Optional: Load database configuration from separate file

// const Sequelize = require('sequelize');
// const config = require('./config/database');
app.use(bodyParser.urlencoded({ extended: true }));

const User = require('./models/User'); // Import your User model
const Car = require('./models/Car'); // Import your Car model
// ... (import other models)

const userController = require('./controllers/userController'); // Import your user controller
const carController = require('./controllers/carController');
// ... (import other controllers)

const user_routes = require('./routes/User_routes'); // Import the routes file
const car_routes = require('./routes/Car_routes');
// User.sync()
//   .then(() => console.log('Users table created successfully!'))
//   .catch(err => console.error('Error creating Users table:', err));

// (async () => {
//   try {
//     await sequelize.sync({ force: false }); // Preserve existing data
//     console.log('Database tables synchronized successfully.');
//   } catch (error) {
//     console.error('Error synchronizing database tables:', error);
//     // Handle the error appropriately, e.g., log details, send a notification, or exit the application
//   }
// })();

app.use('/user',User_routes);
app.use('/car',Car_routes);
//app.use('/admin',Admin_routes);


app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = process.env.PORT || 3000;
app.use(bodyParser.json());

// Import the routes file
const User_routes = require('./routes/User_routes');
const Car_routes = require('./routes/Car_routes');
const Subscription_routes = require('./routes/Subscription_routes');
const ParkingArea_routes = require('./routes/ParkingArea_routes');

const sequelize = require('./db');
// Optional: Load database configuration from separate file

// const Sequelize = require('sequelize');
// const config = require('./config/database');
app.use(bodyParser.urlencoded({ extended: true }));

app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Methods', 'GET, PUT, POST, DELETE, OPTIONS');
  res.setHeader('Access-Control-Max-Age', '1000');
  res.setHeader('Access-Control-Allow-Headers', 'Origin, Content-Type, X-Auth-Token, Authorization');
  next();
});

// const User = require('./models/User'); // Import your User model
// const Car = require('./models/Car'); // Import your Car model
// const Subscription = require('./models/Subscription'); // Import your Subscription model
// const ParkingArea = require('./models/ParkingArea'); // Import your ParkingArea model
// ... (import other models)

// const userController = require('./controllers/userController'); // Import your user controller
// const carController = require('./controllers/carController'); // Import your car controller
// const subscriptionController = require('./controllers/subscriptionController'); // Import your subscription controller
// const parkingAreaController = require('./controllers/parkingAreaController'); // Import your parking area controller
// ... (import other controllers)


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

app.use('/user', User_routes);
app.use('/car', Car_routes);
app.use('/subscription', Subscription_routes);
app.use('/parkingArea', ParkingArea_routes);
//app.use('/admin',Admin_routes);


app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
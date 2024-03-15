const express = require('express');
const app = express();
const port = process.env.PORT || 3000; // Use environment variable or default to port 3000

// Optional: Load database configuration from separate file
const Sequelize = require('sequelize');
const config = require('./config/database');

const User = require('./models/User'); // Import your User model
//const Admin = require('./models/Admin');
// ... (import other models)

const userController = require('./controllers/userController'); // Import your user controller
// ... (import other controllers)

const router = require('./routes/routes'); // Import the routes file

User.sync()
  .then(() => console.log('Users table created successfully!'))
  .catch(err => console.error('Error creating Users table:', err));

(async () => {
  try {
    const sequelize = new Sequelize(config); // Use the imported config
    await sequelize.authenticate();
    console.log('Connection to database has been established successfully.');
  } catch (error) {
    console.error('Unable to connect to the database:', error);
    process.exit(1); // Exit the application on failure
  }
})();

app.use('/usermanagement',router);

app.get('/', (req, res) => {
  res.send('Hello from your Node.js + Sequelize backend!');
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

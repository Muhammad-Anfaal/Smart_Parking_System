const Users = require('../models/User'); // Import your User model
const bcrypt = require('bcrypt'); // Import bcrypt for password comparison
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const secretKey = crypto.randomBytes(32).toString('hex'); //it will produce 32 bytes secret key 
console.log(secretKey);

exports.createUser = async (req, res) => {
  try {
    const { userName, userEmail, userPhoneNumber, userCity, userCNIC, userAddress, userPassword, userType } = req.body; // Extract userType

    // Validate user data (including userType)
    // ... validation logic (e.g., using libraries like Joi)

    // ... rest of createUser code

    const newUser = await Users.create({
      userName,
      userEmail,
      userPhoneNumber,
      userCity,
      userCNIC,
      userAddress,
      userPassword: hashedPassword,
      userType // Include userType in creation
    });

    // ... rest of createUser code
  } catch (error) {
    // ... error handling
  }
};

exports.getAllUsers = async (req, res) => {
  try {
    const users = await Users.findAll(); // Includes userType in fetched data
    res.json(users);
  } catch (error) {
    // ... error handling
  }
};

exports.getUserById = async (req, res) => {
  try {
    // ...
    const user = await Users.findByPk(userId, {
      attributes: ['userId', 'userName', 'userEmail', 'userPhoneNumber', 'userCity', 'userCNIC', 'userAddress', 'userType'] // Include userType in response
    });
    // ...
  } catch (error) {
    // ... error handling
  }
};

exports.updateUser = async (req, res) => {
  try {
    const userId = req.params.id;
    const { userName, userEmail, userPhoneNumber, userCity, userCNIC, userAddress, userType } = req.body;

    // Validate user data (including userType)
    // ... validation logic

    // ...

    user.userType = userType; // Update userType if provided

    await user.save();

    res.json(user); // Includes updated userType
  } catch (error) {
    // ... error handling
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const userId = req.params.id; // Assuming user ID is in the route parameter

    const user = await Users.findByPk(userId);

    if (!user) {
      return res.status(404).send('User not found');
    }

    await user.destroy();

    res.status(204).send(); // No content to send, user deleted successfully
  } catch (error) {
    console.error('Error deleting user:', error);
    res.status(500).send('Error'); // Handle errors appropriately
  }
};

// Function to login a user (assuming username and password are provided in request body)
exports.loginUser = async (req, res) => {
  try {
    const { userName, userPassword } = req.body;

    const user = await Users.findOne({ where: { userName } });

    if (!user) {
      return res.status(401).send('Invalid username or password');
    }

    const passwordMatch = await bcrypt.compare(userPassword, user.userPassword);

    if (!passwordMatch) {
      return res.status(401).send('Invalid username or password');
    }

    // Check if the user already has a stored token
    let userToken = user.token;

    // If not, generate a new one
    if (!userToken) {
      userToken = jwt.sign({ userId: user.id, userName: user.userName }, secretKey, { expiresIn: '1h' });

      // Save the new token in the database or associate it with the user
      user.token = userToken;
      await user.save();
    }

    res.json({ message: 'Login successful', token: userToken });
  } catch (error) {
    console.error('Error logging in user:', error);
    res.status(500).send('Error logging in user');
  }
};

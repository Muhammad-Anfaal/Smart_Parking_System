const Users = require('../models/User'); // Import your User model
const bcrypt = require('bcrypt'); // Import bcrypt for password comparison

exports.createUser = async (req, res) => {
  try {
    const { userName, userEmail, userPhoneNumber, userCity, userCNIC, userAddress, userPassword } = req.body;

    // Validate user data (optional, can be done using middleware)
    // ... validation logic (e.g., using libraries like Joi)

    const hashedPassword = await bcrypt.hash(userPassword, 10); // Hash password before saving

    const newUser = await Users.create({
      userName,
      userEmail,
      userPhoneNumber,
      userCity,
      userCNIC,
      userAddress,
      userPassword: hashedPassword
    });

    res.json(newUser); // Send response with created user data
  } catch (error) {
    console.error('Error creating user:', error);
    res.status(500).send('Error'); // Handle errors appropriately
  }
};

exports.getAllUsers = async (req, res) => {
  try {
    const users = await Users.findAll();
    res.json(users); // Send response with all users
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).send('Error'); // Handle errors appropriately
  }
};

exports.getUserById = async (req, res) => {
  try {
    const userId = req.params.id; // Assuming user ID is in the route parameter

    const user = await Users.findByPk(userId);

    if (!user) {
      return res.status(404).send('User not found');
    }

    res.json(user); // Send response with the found user
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).send('Error'); // Handle errors appropriately
  }
};

exports.updateUser = async (req, res) => {
  try {
    const userId = req.params.id; // Assuming user ID is in the route parameter
    const { userName, userEmail, userPhoneNumber, userCity, userCNIC, userAddress } = req.body;

    // Validate user data (optional, can be done using middleware)
    // ... validation logic (e.g., using libraries like Joi)

    const user = await Users.findByPk(userId);

    if (!user) {
      return res.status(404).send('User not found');
    }

    user.userName = userName;
    user.userEmail = userEmail; // Be cautious updating email as it might require verification again
    user.userPhoneNumber = userPhoneNumber;
    user.userCity = userCity;
    user.userCNIC = userCNIC;
    user.userAddress = userAddress;

    await user.save(); // Save updated user data

    res.json(user); // Send response with the updated user
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(500).send('Error'); // Handle errors appropriately
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
      return res.status(401).send('Invalid username or password'); // Unauthorized
    }

    const passwordMatch = await bcrypt.compare(userPassword, userPassword); // typo corrected

    if (!passwordMatch) {
      return res.status(401).send('Invalid username or password'); // Unauthorized
    }

    // Login successful (logic for generating tokens or session management can be added here)
    const userToken = generateAuthToken(user.id); // Replace with your token generation function
    res.json({ message: 'Login successful', token: userToken });
  } catch (error) {
    console.error('Error logging in user:', error);
    res.status(500).send('Error'); // Handle errors appropriately
  }
};

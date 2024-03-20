
 // Import your database connection
const Users = require('../models/User'); // Import your User model
// const Subscription = require('../models/Subscription');
const bcrypt = require('bcrypt'); // Import bcrypt for password comparison
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const secretKey = crypto.randomBytes(32).toString('hex'); //it will produce 32 bytes secret key 
// console.log(secretKey);

exports.createUser = async (req, res) => {
  try {
    
    const { userName, userEmail, userPhoneNumber, userCity, userCNIC, userAddress, userPassword, userType } = req.body;

    // Validate user data (including userType)
    // ... validation logic

    // Hash the password
    const hashedPassword = await bcrypt.hash(userPassword, 10);
    

    // Create the new user
    const newUser = await Users.create({
      userName,
      userEmail,
      userPhoneNumber,
      userCity,
      userCNIC,
      userAddress,
      userPassword: hashedPassword,
      userType
    });

    res.json(newUser);
  } catch (error) {
    console.error('Error creating user:', error);
    res.status(500).send('Error creating user');
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

// ///___________________Subscription part_______________________///

// // Controller function to get a user's subscription
// exports.getUserSubscription = async (req, res) => {
//   try {
//     const userId = req.params.userId;

//     // Find the user's subscription
//     const subscription = await Subscription.findOne({ where: { userId } });

//     if (!subscription) {
//       return res.json({ hasSubscription: false });
//     }

//     res.json({ hasSubscription: true, subscription });
//   } catch (error) {
//     console.error('Error fetching user subscription:', error);
//     res.status(500).send('Error fetching user subscription');
//   }
// };

// // Controller function to create a subscription for a user
// exports.createUserSubscription = async (req, res) => {
//   try {
//     const { userId, duration } = req.body;

//     // Check if the user already has a subscription
//     const existingSubscription = await Subscription.findOne({ where: { userId } });

//     if (existingSubscription) {
//       return res.status(400).send('User already has a subscription');
//     }

//     // Create a new subscription
//     const subscription = await Subscription.create({ userId, duration, status: 'active' });

//     res.status(201).json(subscription);
//   } catch (error) {
//     console.error('Error creating user subscription:', error);
//     res.status(500).send('Error creating user subscription');
//   }
// };

// // Controller function to cancel a user's subscription
// exports.cancelUserSubscription = async (req, res) => {
//   try {
//     const userId = req.params.userId;

//     // Find the user's subscription
//     const subscription = await Subscription.findOne({ where: { userId } });

//     if (!subscription) {
//       return res.status(404).send('Subscription not found');
//     }

//     // Cancel the subscription
//     await subscription.update({ status: 'inactive' });

//     res.status(204).send();
//   } catch (error) {
//     console.error('Error canceling user subscription:', error);
//     res.status(500).send('Error canceling user subscription');
//   }
// };
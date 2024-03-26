
// Import your database connection
const Users = require('../models/User'); // Import your User model
const Car = require('../models/Car'); // Import your Car model
// const Subscription = require('../models/Subscription');
const bcrypt = require('bcrypt'); // Import bcrypt for password comparison

// const jwt = require('jsonwebtoken');

// const crypto = require('crypto');
// const secretKey = crypto.randomBytes(32).toString('hex'); //it will produce 32 bytes secret key 
// console.log(secretKey);

exports.createUser = async (req, res) => {
  try {

    const { userName, userEmail, userPhoneNumber, userCity, userCNIC, userAddress, userPassword, userType, userImage } = req.body;

    // Check if the user already exists
    const existingUser = await Users.findOne({ where: { userEmail } });

    if (existingUser) {
      return res.status(400).send('User already exists');
    }

    // Hash the password
    console.log('userPassword', userPassword);
    hashedPassword = await bcrypt.hash(userPassword, 10);


    // Create the new user
    const newUser = await Users.create({
      userName,
      userEmail,
      userPhoneNumber,
      userCity,
      userCNIC,
      userAddress,
      userPassword: hashedPassword,
      userType,
      userImage
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
    console.error('Error fetching users:', error);
    res.status(500).send('Error fetching users');
  }
};


exports.updateUser = async (req, res) => {
  try {
    const { userName, userEmail, userPhoneNumber, userCity, userCNIC, userAddress, userPassword, userType, userImage } = req.body;

    // Find the user by email
    const user = await Users.findOne({ where: { userEmail } });

    if (!user) {
      return res.status(404).send('User not found');
    }

    // Hash the password
    hashedPassword = await bcrypt.hash(userPassword, 10);

    // Update the user
    await user.update({
      userName,
      userEmail,
      userPhoneNumber,
      userCity,
      userCNIC,
      userAddress,
      userPassword: hashedPassword,
      userType,
      userImage
    });

    res.json(user);
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(500).send('Error updating user');
  }
};

exports.validateUser = async (req, res) => {
  try {
    const { email, password, utype } = req.body;

    const user = await Users.findOne({ where: { userEmail: email, userType: utype } });

    if (!user) {
      console.log('User not found');
      return res.status(404).send('User not found');
    }

    passwordMatch = await bcrypt.compare(password, user.userPassword);

    if (!passwordMatch) {
      console.log('Invalid username or password');
      return res.status(401).send('Invalid username or password');
    }

    res.json({ message: 'User is valid' });
    console.log('User logged in successfully');
  } catch (error) {
    console.error('Error validating user:', error);
    res.status(500).send('Error validating user');
  }
};



exports.deleteUser = async (req, res) => {
  try {
    const email = req.body.email;

    // Find the user by email
    const user = await Users.findOne({ where: { userEmail: email } });

    if (!user) {
      return res.status(404).send('User not found');
    }

    // Find all cars belonging to the user
    const userCars = await Car.findAll({ where: { userId: user.userId } });

    // Delete all cars belonging to the user
    await Car.destroy({ where: { userId: user.userId } });

    // Delete the user
    await user.destroy();

    res.status(204).send(); // No content to send, user and related cars deleted successfully
  } catch (error) {
    console.error('Error deleting user and related cars:', error);
    res.status(500).send('Error deleting user and related cars');
  }
};

// // Function to login a user (assuming username and password are provided in request body)
// exports.loginUser = async (req, res) => {
//   try {
//     const { email, password } = req.params;

//     const user = await Users.findOne({ where: { userEmail: email } });

//     if (!user) {
//       return res.status(401).send('Invalid username or password');
//     }

//     const passwordMatch = await bcrypt.compare(password, user.userPassword);

//     if (!passwordMatch) {
//       return res.status(401).send('Invalid username or password');
//     }

//     // Check if the user already has a stored token
//     let userToken = user.token;

//     // If not, generate a new one
//     if (!userToken) {
//       userToken = jwt.sign({ userId: user.id, userName: user.userName }, secretKey, { expiresIn: '1h' });

//       // Save the new token in the database or associate it with the user
//       user.token = userToken;
//       await user.save();
//     }

//     res.json({ message: 'Login successful', token: userToken });
//   } catch (error) {
//     console.error('Error logging in user:', error);
//     res.status(500).send('Error logging in user');
//   }
// };

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
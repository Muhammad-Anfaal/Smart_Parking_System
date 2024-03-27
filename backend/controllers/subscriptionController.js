const Subscription = require('../models/Subscription');
const User = require('../models/User');

// Function to create a subscription for a user
exports.createSubscription = async (req, res) => {
  try {
    const { email, subscriptionType } = req.body;

    // Check if the user exists

    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Check if the user already has a subscription
    const existingSubscription = await Subscription.findOne({ where: { userId: user.userId } });
    if (existingSubscription) {
      console.log('User already has subscription');
      return res.status(400).send('User already has subscription');
    }

    // Calculate the subscription end date based on subscription type
    const subscriptionStartDate = new Date();
    let subscriptionEndDate = new Date();
    if (subscriptionType === '1 month') {
      subscriptionEndDate.setMonth(subscriptionEndDate.getMonth() + 1);
    } else if (subscriptionType === '2 months') {
      subscriptionEndDate.setMonth(subscriptionEndDate.getMonth() + 2);
    } else if (subscriptionType === '3 months') {
      subscriptionEndDate.setMonth(subscriptionEndDate.getMonth() + 3);
    } else {
      return res.status(400).send('Invalid subscription type');
    }

    // Create the subscription
    const newSubscription = await Subscription.create({
      userId: user.userId,
      subscriptionType,
      subscriptionStartDate,
      subscriptionEndDate
    });

    res.status(201).json(newSubscription);
  } catch (error) {
    console.error('Error creating subscription:', error);
    res.status(500).send('Error creating subscription');
  }
};

// Function to get a user's subscription
exports.getUserSubscription = async (req, res) => {
  try {
    const email = req.body.email;

    // Check if the user exists
    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Find the user's subscription
    const subscription = await Subscription.findOne({ where: { userId: user.userId } });
    if (!subscription) {
      return res.status(404).send('User does not have an active subscription');
    }

    res.json(subscription);
  } catch (error) {
    console.error('Error getting user subscription:', error);
    res.status(500).send('Error getting user subscription');
  }
};

const Subscription = require('../models/Subscription');
const ParkingArea = require('../models/ParkingArea');
const User = require('../models/User');
// Function to view subscriptions of all users
exports.viewAllSubscriptions = async (req, res) => {
  try {
    // Fetch all subscriptions
    const allSubscriptions = await Subscription.findAll();

    res.status(200).json(allSubscriptions);
  } catch (error) {
    console.error('Error fetching subscriptions:', error);
    res.status(500).send('Error fetching subscriptions');
  }
};

// Function to cancel a user's subscription
exports.cancelUserSubscription = async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }
    // Check if the user has any subscription
    const existingSubscription = await Subscription.findOne({ where: { userId:user.userId } });
    if (!existingSubscription) {
      return res.status(404).send('User does not have any subscription');
    }

    // Cancel the subscription
    await existingSubscription.destroy();

    res.status(200).send('Subscription canceled successfully');
  } catch (error) {
    console.error('Error canceling user subscription:', error);
    res.status(500).send('Error canceling user subscription');
  }
};

// Function to change the status of a parking area from Inactive to Active
exports.activeParkingAreaStatus = async (req, res) => {
  try {
    const { parkingAreaName } = req.body;

    // Check if the parking area exists    
    const parkingArea = await ParkingArea.findOne({ where: { parkingAreaName : parkingAreaName } });
    if (!parkingArea) {
      return res.status(404).send('parking not found');
    }
    // Update the parking area status to Active
    await parkingArea.update({ parkingAreaStatus: 'Active' });

    res.json(parkingArea);
  } catch (error) {
    console.error('Error changing parking area status:', error);
    res.status(500).send('Error changing parking area status');
  }
};

// Function to extend the capacity of a parking area
exports.extendParkingAreaCapacity = async (req, res) => {
  try {
    const { parkingAreaName, count } = req.body;

    // Check if the parking area exists
    const parkingArea = await ParkingArea.findOne({ where: { parkingAreaName : parkingAreaName } });
    if (!parkingArea) {
      return res.status(404).send('parking not found');
    }

    // Update the parking area capacity
    const newCapacity = parkingArea.parkingAreaCapacity + parseInt(count);
    await parkingArea.update({ parkingAreaCapacity: newCapacity });

    res.json(parkingArea);
  } catch (error) {
    console.error('Error extending parking area capacity:', error);
    res.status(500).send('Error extending parking area capacity');
  }
};
const ParkingArea = require('../models/ParkingArea');
const User = require('../models/User');

exports.registerParkingArea = async (req, res) => {
  try {
    const { parkingAreaName, parkingAreaLocation, parkingAreaCapacity, parkingAreaImage, parkingAreaStatus, email } = req.body;
    
    // Check if the user exists

    // Register a new parking area
    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }
    const userId = user.userId;

    const newParkingArea = await ParkingArea.create({
      userId,
      parkingAreaName,
      parkingAreaLocation,
      parkingAreaCapacity,
      parkingAreaImage,
      parkingAreaStatus
    });

    res.status(201).json(newParkingArea);
  } catch (error) {
    console.error('Error registering parking area:', error);
    res.status(500).send('Error registering parking area');
  }
};


exports.getUserParkingAreas = async (req, res) => {
  try {
    const email = req.body.email;

    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Fetch all parking areas belonging to the user
    const userParkingAreas = await ParkingArea.findAll({ where: { userId : userId } });

    res.json(userParkingAreas);
  } catch (error) {
    console.error('Error fetching user parking areas:', error);
    res.status(500).send('Error fetching user parking areas');
  }
};

exports.getAllParkingAreas = async (req, res) => {
  try {
    const parkingAreas = await ParkingArea.findAll({ where: { parkingAreaStatus: 'Active' } });
    res.json(parkingAreas);
  } catch (error) {
    console.error('Error fetching parking areas:', error);
    res.status(500).send('Error fetching parking areas');
  }
};

exports.updateParkingArea = async (req, res) => {
  try {
    const { userId, parkingAreaId } = req.params;

    // Check if the user exists
    const user = await User.findByPk(userId);
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Check if the Parking Area exists and belongs to the user
    const parkingArea = await ParkingArea.findOne({ where: { parkingAreaId, userId } });
    if (!parkingArea) {
      return res.status(404).send('Parking Area not found');
    }

    const { parkingAreaName, parkingAreaCapacity, parkingAreaImage, parkingAreaStatus } = req.body;
    await parkingArea.update({ parkingAreaName, parkingAreaCapacity, parkingAreaImage, parkingAreaStatus });

    res.json(parkingArea);
  } catch (error) {
    console.error('Error updating user Parking Area:', error);
    res.status(500).send('Error updating Parking Area');
  }
};


exports.removeParkingArea = async (req, res) => {
  try {
    const { userId, parkingAreaId } = req.params;

    // Check if the user exists
    const user = await User.findByPk(userId);
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Check if the parking area exists and belongs to the user
    const parkingArea = await ParkingArea.findOne({ where: { parkingAreaId, userId } });
    if (!parkingArea) {
      return res.status(404).send('Parking Area not found');
    }

    await parkingArea.destroy();
    res.status(204).send();
  } catch (error) {
    console.error('Error removing parking area:', error);
    res.status(500).send('Error removing parking area');
  }
};

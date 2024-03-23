const express = require('express');
const router = express.Router();
const parkingAreaController = require('../controllers/parkingAreaController');

// Register a new parking area
router.post('/users/:userId/parkingAreas', parkingAreaController.registerParkingArea);

// Update an existing parking area
router.put('/users/:userId/parkingAreas/:parkingAreaId', parkingAreaController.updateParkingArea);

// Remove a parking area
router.delete('/users/:userId/parkingAreas/:parkingAreaId', parkingAreaController.removeParkingArea);

// Fetch all parking areas of a user
router.get('/users/:userId/parkingAreas', parkingAreaController.getUserParkingAreas);

module.exports = router;

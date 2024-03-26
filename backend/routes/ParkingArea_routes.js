const express = require('express');
const router = express.Router();
const parkingAreaController = require('../controllers/parkingAreaController');

// Register a new parking area
router.post('/registerparkingarea', parkingAreaController.registerParkingArea);

// Update an existing parking area
router.put('/updateparkingarea', parkingAreaController.updateParkingArea);

// Remove a parking area
router.delete('/removeparkingarea', parkingAreaController.removeParkingArea);

// Fetch all parking areas of a user
router.get('/userparkingareas', parkingAreaController.getUserParkingAreas);

// Fetch all parking areas
router.get('/allparkingareas', parkingAreaController.getAllParkingAreas);
module.exports = router;

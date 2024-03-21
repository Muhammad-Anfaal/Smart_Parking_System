const express = require('express');
const router = express.Router();
const carController = require('../controllers/carController');

// Register a new car
router.post('/cars/:userId', carController.registerCar);

// Remove a car
router.delete('/users/:userId/cars/:carId', carController.removeCar);

// Fetch all cars of a user
router.get('/users/:userId/cars', carController.getUserCars);
module.exports = router;

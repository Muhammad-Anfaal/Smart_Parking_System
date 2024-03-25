const express = require('express');
const router = express.Router();
const carController = require('../controllers/carController');

// Register a new car
router.post('/registercar', carController.registerCar);

// Remove a car
router.delete('/deletecar', carController.removeCar);

// Fetch all cars of a user
router.get('/allcars', carController.getUserCars);
module.exports = router;

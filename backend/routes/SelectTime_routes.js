const express = require('express');
const router = express.Router();
const selectTimeController = require('../controllers/selectTimeController');

// Register new time slot
router.post('/registertime', selectTimeController.registerTime);

// Fetch all times of a user
router.get('/usertimes', selectTimeController.getUserTimes);

// Fetch all times
router.get('/alltimes', selectTimeController.getAllTimes);

module.exports = router;

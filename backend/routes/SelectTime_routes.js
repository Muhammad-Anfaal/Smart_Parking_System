const express = require('express');
const router = express.Router();
const selectTimeController = require('../controllers/selectTimeController');

// Register new time slot
router.post('/registertime', selectTimeController.registerTime);

// Fetch all times of a user
router.get('/usertimes/:email', selectTimeController.getUserTimes);

// Fetch all times
router.get('/alltimes', selectTimeController.getAllTimes);

// Extend time
router.put('/extendtime', selectTimeController.extendTime);

module.exports = router;

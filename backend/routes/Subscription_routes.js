const express = require('express');
const router = express.Router();
const subscriptionController = require('../controllers/subscriptionController');

// Route to create a subscription
router.post('/create', subscriptionController.createSubscription);

// Route to get a user's subscription
router.get('/viewsubscription', subscriptionController.getUserSubscription);

module.exports = router;
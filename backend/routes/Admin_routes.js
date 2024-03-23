const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');

// View all subscriptions
router.get('/subscriptions', adminController.viewAllSubscriptions);

// Cancel a user's subscription
router.delete('/subscriptions/:userId', adminController.cancelUserSubscription);

// Change the status of a parking area from Inactive to Active
router.put('/parking-areas/:parkingAreaId/activate', adminController.changeParkingAreaStatus);

// Extend the capacity of a parking area
router.put('/parking-areas/:parkingAreaId/extend-capacity/:count', adminController.extendParkingAreaCapacity);

module.exports = router;
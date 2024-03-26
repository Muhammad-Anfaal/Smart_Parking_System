const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');

// View all subscriptions
router.get('/subscriptions', adminController.viewAllSubscriptions);

// Cancel a user's subscription
router.delete('/deletesubscription', adminController.cancelUserSubscription);

// Change the status of a parking area from Inactive to Active
router.put('/activeparkingareastatus', adminController.activeParkingAreaStatus);

// Extend the capacity of a parking area
router.put('/extendparkingarea', adminController.extendParkingAreaCapacity);

module.exports = router;
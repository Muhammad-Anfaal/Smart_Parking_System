const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController'); // Import your user controller
// ... (import other controllers as needed)

router.get('/users', userController.getAllUsers);
router.post('/createusers', userController.createUser);
router.get('/usersbyid/:id', userController.getUserById);
router.put('/updateusers/:id', userController.updateUser);
router.delete('/deleteusers/:id', userController.deleteUser);
router.post('/users/login', userController.loginUser); // Assuming login route in userController

// Routes for managing user subscriptions
// router.get('/users/:userId/subscription', userController.getUserSubscription);
// router.post('/users/:userId/subscription', userController.createUserSubscription);
// router.delete('/users/:userId/subscription', userController.cancelUserSubscription);

module.exports = router;
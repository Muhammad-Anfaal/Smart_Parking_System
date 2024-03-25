const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController'); // Import your user controller
// ... (import other controllers as needed)

router.get('/users', userController.getAllUsers);
router.post('/createuser', userController.createUser);
router.put('/updateuser', userController.updateUser);
router.delete('/deleteuser', userController.deleteUser);
router.post('/validateuser', userController.validateUser);

//Routes for managing user subscriptions
// router.get('/users/:userId/subscription', userController.getUserSubscription);
// router.post('/users/:userId/subscription', userController.createUserSubscription);
// router.delete('/users/:userId/subscription', userController.cancelUserSubscription);

module.exports = router;
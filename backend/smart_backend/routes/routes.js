const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController'); // Import your user controller
// ... (import other controllers as needed)

router.get('/users', userController.getAllUsers);
router.post('/users', userController.createUser);
router.get('/users/:id', userController.getUserById);
router.put('/users/:id', userController.updateUser);
router.delete('/users/:id', userController.deleteUser);
router.post('/users/login', userController.loginUser); // Assuming login route in userController

// ... (routes for other controllers)

module.exports = router;
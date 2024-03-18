const express = require('express');
const router = express.Router();

const userController = require('../controllers/userController'); // Import your user controller
// ... (import other controllers as needed)

router.get('/', userController.getAllUsers);
router.post('/createusers', userController.createUser);
router.get('/usersbyid/:id', userController.getUserById);
router.put('/updateusers/:id', userController.updateUser);
router.delete('/deleteusers/:id', userController.deleteUser);
router.post('/users/login', userController.loginUser); // Assuming login route in userController

// ... (routes for other controllers)

module.exports = router;
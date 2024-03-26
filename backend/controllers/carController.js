const Car = require('../models/Car');
const User = require('../models/User');

exports.registerCar = async (req, res) => {
  try {
    const { email, carNumber, carYear, carColor, carState } = req.body;

    // Check if the user exists
    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Check if the user has already registered 3 cars
    const carCount = await Car.count({ where: { userId : user.userId } });
    if (carCount > 3) {
      return res.status(400).send('User has already registered the maximum number of cars');
    }

    // Check if the car number format is valid and unique
    const existingCar = await Car.findOne({ where: { carNumber : carNumber } });
    if (existingCar) {
      return res.status(400).send('Car number already exists');
    }

    // Validate car state
    const validStates = ['Punjab', 'Sindh', 'KPK', 'Balochistan', 'Islamabad'];
    if (!validStates.includes(carState)) {
      return res.status(400).send('Invalid car state');
    }

    // Validate car make (year)
    const currentYear = new Date().getFullYear();
    if (carYear > currentYear) {
      return res.status(400).send('Invalid car make (year)');
    }

    const userId = user.userId;
    const newCar = await Car.create({
      carNumber,
      carYear,
      carColor,
      carState,
      userId
    });

    res.status(201).json(newCar);
  } catch (error) {
    console.error('Error registering car:', error);
    res.status(500).send('Error registering car');
  }
};


exports.getUserCars = async (req, res) => {
  try {
    const email = req.body.email;

    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Fetch all cars belonging to the user
    const userCars = await Car.findAll({ where: { userId : user.userId } });

    res.json(userCars);
  } catch (error) {
    console.error('Error fetching user cars:', error);
    res.status(500).send('Error fetching user cars');
  }
};


exports.removeCar = async (req, res) => {
  try {
    const { email, carnumber } = req.body;

    // Check if the user exists
    const user = await User.findOne({ where: { userEmail: email } });
    if (!user) {
      return res.status(404).send('User not found');
    }

    // Check if the car exists and belongs to the user
    const car = await Car.findOne({ where: { carNumber : carnumber, userId : user.userId } });
    if (!car) {
      return res.status(404).send('Car not found');
    }

    await car.destroy();
    res.status(204).send();
  } catch (error) {
    console.error('Error removing car:', error);
    res.status(500).send('Error removing car');
  }
};

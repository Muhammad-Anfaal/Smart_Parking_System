const SelectTime = require('../models/SelectTime');
const User = require('../models/User');

exports.registerTime = async (req, res) => {
    try {
        const { email, starttime, endtime, date, amount } = req.body;

        // Check if the user exists
        const user = await User.findOne({ where: { userEmail: email } });
        if (!user) {
            return res.status(404).send('User not found');
        }

        const userId = user.userId;

        const newTime = await SelectTime.create({
            userId,
            startTime: starttime,
            endTime: endtime,
            date,
            amount
        });



        res.status(200).json(newTime);
    } catch (error) {
        console.error('Error registering time:', error);
        res.status(500).send('Error registering time');
    }
}

exports.getUserTimes = async (req, res) => {
    try {
        const email = req.body.email;

        const user = await User.findOne({ where: { userEmail: email } });
        if (!user) {
            return res.status(404).send('User not found');
        }

        // Fetch all times belonging to the user
        const userTime = await SelectTime.findOne({ where: { userId: user.userId } });

        res.json(userTime);
    } catch (error) {
        console.error('Error fetching user times:', error);
        res.status(500).send('Error fetching user times');
    }
}

exports.getAllTimes = async (req, res) => {
    try {
        const times = await SelectTime.findAll();
        res.json(times);
    } catch (error) {
        console.error('Error fetching times:', error);
        res.status(500).send('Error fetching times');
    }
}




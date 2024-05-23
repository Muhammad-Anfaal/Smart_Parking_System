const SelectTime = require('../models/SelectTime');
const User = require('../models/User');

exports.registerTime = async (req, res) => {
    try {
        const { email, starttime, endtime, date, amount, parkingareaname } = req.body;

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
            amount,
            parkingAreaName: parkingareaname
        });



        res.status(200).json(newTime);
    } catch (error) {
        console.error('Error registering time:', error);
        res.status(500).send('Error registering time');
    }
}

exports.extendTime = async (req, res) => {
    try {
        const { email, endtime, amount } = req.body;

        // Check if the user exists
        const user = await User.findOne({ where: { userEmail: email } });
        if (!user) {
            return res.status(404).send('User not found');
        }

        const userId = user.userId;

        // Find the time by id
        const time = await SelectTime.findOne({ where: { userId: user.UserID } });
        if (!time) {
            return res.status(404).send('Time not found');
        }

        // Declare an integer variable
        const newAmount = amount + time.amount;


        // Update the time
        await time.update({
            endTime: endtime,
            newAmount
        });

        res.json(time);

    } catch (error) {
        console.error('Error extending time:', error);
        res.status(500).send('Error extending time');
    }
}


exports.getUserTimes = async (req, res) => {
    try {
        // Fetch all times belonging to the user
        const userTime = await SelectTime.findAll({ where: { parkingAreaName: 'fast cfd' } });

        length(userTime)

        res.json(length(userTime));
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




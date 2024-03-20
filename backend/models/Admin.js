// const Sequelize = require('sequelize');
// const bcrypt = require('bcrypt');

// const adminCredentials = [
//   { name: 'anfaal', password: 'anf123' },
//   { name: 'awab', password: 'awa123' },
//   { name: 'abdullah', password: 'abd123' }
// ];

// const Admin = sequelize.define('Admin', {
//   adminId: {
//     type: Sequelize.INTEGER,
//     autoIncrement: true,
//     primaryKey: true
//   },
//   adminName: {
//     type: Sequelize.STRING,
//     allowNull: false,
//     unique: true,
//     validate: {
//       isIn: adminCredentials.map(cred => cred.name)
//     }
//   },
//   adminPassword: {
//     type: Sequelize.STRING,
//     allowNull: false,
//     set(value) {
//       // Hash password before saving
//       const salt = bcrypt.genSaltSync(10);
//       // Find the corresponding password for the adminName
//       const credential = adminCredentials.find(cred => cred.name === this.getDataValue('adminName'));
//       if (credential) {
//         this.setDataValue('adminPassword', bcrypt.hashSync(credential.password, salt));
//       } else {
//         throw new Error('Invalid adminName');
//       }
//     }
//   }
// });

// module.exports = Admin;
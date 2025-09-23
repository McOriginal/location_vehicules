const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const UserSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Veuillez ajouter un nom'],
  },
  adresse: {
    type: String,
    required: [true, 'Veuillez ajouter un nom'],
  },
  phoneNumber: {
    type: Number,
    required: [true, 'Veuillez ajouter un numéro de téléphone'],
  },
  companyName: {
    type: String,
    required: [true, 'Veuillez ajouter le nom de la société'],
  },
  email: {
    type: String,
    required: [true, 'Veuillez ajouter un email'],
    unique: true,
    match: [
      /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
      'Veuillez ajouter un email valide',
    ],
  },
  password: {
    type: String,
    required: [true, 'Veuillez ajouter un mot de passe'],
    minlength: 4,
    select: false, // Ne pas renvoyer le mot de passe par défaut
  },
  role: {
    type: String,
    enum: ['client', 'locateur'],
    default: 'client',
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

// Hachage du mot de passe avant l'enregistrement
UserSchema.pre('save', async function (next) {
  if (!this.isModified('password')) {
    next();
  }
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
});

// Générer le token JWT
// UserSchema.methods.getSignedJwtToken = function () {
//   return jwt.sign({ id: this._id }, process.env.JWT_SECRET, {
//     expiresIn: process.env.JWT_EXPIRE || '1h',
//   });
// };

// Vérifier si le mot de passe correspond
// UserSchema.methods.matchPassword = async function (enteredPassword) {
//   return await bcrypt.compare(enteredPassword, this.password);
// };
const User = mongoose.model('User', UserSchema);
module.exports = User;

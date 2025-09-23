const mongoose = require('mongoose');

const RentalSchema = new mongoose.Schema({
  client: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    required: true,
  },
  vehicle: {
    type: mongoose.Schema.ObjectId,
    ref: 'Vehicle',
    required: true,
  },
  startDate: {
    type: Date,
    required: [true, 'Veuillez spécifier une date de début'],
  },
  endDate: {
    type: Date,
    required: [true, 'Veuillez spécifier une date de fin'],
  },
  status: {
    type: String,
    enum: ['en attente', 'confirmée', 'annulée', 'terminée'],
    default: 'en attente',
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('Rental', RentalSchema);

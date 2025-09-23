const mongoose = require('mongoose');

const VehicleSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Veuillez ajouter un nom de véhicule'],
  },

  type: {
    type: String,
    enum: ['mariage', 'business', 'voyage', 'aventure'],
    required: [true, 'Veuillez spécifier un type'],
  },
  price: {
    type: Number,
    required: [true, 'Veuillez ajouter un prix par jour'],
  },
  images: [String], // URL des images

  color: {
    type: String,
    required: [true, 'Veuillez ajouter une couleur'],
  },
  isAvailable: {
    type: Boolean,
    default: true,
  },
  description: {
    type: String,
  },
  owner: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model('Vehicle', VehicleSchema);

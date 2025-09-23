const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log('MongoDB connectée avec succès !');
  } catch (err) {
    console.error(`Erreur de connexion à MongoDB : ${err.message}`);
    // Arrêter l'application en cas d'erreur fatale
    process.exit(1);
  }
};

module.exports = connectDB;

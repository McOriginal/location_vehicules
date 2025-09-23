const express = require('express');
const dotenv = require('dotenv');
const connectDB = require('./config/db');

// Routes
const authRoutes = require('./routes/authRoutes');
const vehicleRoutes = require('./routes/vehicleRoutes');
const rentalRoutes = require('./routes/rentalRoutes');

// Charger les variables d'environnement
dotenv.config();

// Connexion à la base de données
connectDB();

const app = express();

// Middleware pour parser le JSON
app.use(express.json());

// Points d'accès de l'API
app.use('/api/auth', authRoutes);
app.use('/api/vehicles', vehicleRoutes);
app.use('/api/rentals', rentalRoutes);

// Gérer les erreurs de routes non trouvées
app.use((req, res, next) => {
  const error = new Error('Route non trouvée');
  error.status = 404;
  next(error);
});

// Gérer les erreurs globales
app.use((error, req, res, next) => {
  res.status(error.status || 500);
  res.json({
    error: {
      message: error.message,
    },
  });
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Connecté au port ${PORT}`);
});

const express = require('express');
const {
  createRental,
  getMyRentals,
  getRentalsForMyVehicles,
  updateRentalStatus,
} = require('../controllers/rentalController');
const { protect, authorize } = require('../middleware/authMiddleware');

const router = express.Router();

// Routes pour les clients
router.post('/', protect, authorize('client'), createRental);
router.get('/my', protect, authorize('client'), getMyRentals);

// Routes pour les locateurs
router.get(
  '/my-rentals',
  protect,
  authorize('locateur'),
  getRentalsForMyVehicles
);
router.put('/:id', protect, authorize('locateur'), updateRentalStatus);

module.exports = router;

const express = require('express');
const {
  createVehicle,
  getMyVehicles,
  updateVehicle,
  deleteVehicle,
  getVehicles,
  getVehicle,
} = require('../controllers/vehicleController');
const { protect, authorize } = require('../middleware/authMiddleware');

const router = express.Router();

// Routes pour les locateurs (protégées)
router.post('/', protect, authorize('locateur'), createVehicle);
router.get('/my', protect, authorize('locateur'), getMyVehicles);
router.put('/:id', protect, authorize('locateur'), updateVehicle);
router.delete('/:id', protect, authorize('locateur'), deleteVehicle);

// Routes pour les clients et le public
router.get('/', getVehicles); // Pour la liste des véhicules
router.get('/:id', getVehicle); // Pour les détails d'un véhicule

module.exports = router;

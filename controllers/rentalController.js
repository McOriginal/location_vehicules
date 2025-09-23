const asyncHandler = require('../middleware/asyncHandler');
const ErrorResponse = require('../utils/errorHandler');
const Rental = require('../models/Rental');
const Vehicle = require('../models/Vehicle');

// @desc    Créer une nouvelle réservation
// @route   POST /api/rentals
// @access  Private (Client)
exports.createRental = asyncHandler(async (req, res, next) => {
  const { vehicleId, startDate, endDate } = req.body;
  const clientId = req.user.id;

  const vehicle = await Vehicle.findById(vehicleId);

  if (!vehicle) {
    return next(
      new ErrorResponse(`Véhicule non trouvé avec l'id ${vehicleId}`, 404)
    );
  }

  const rental = await Rental.create({
    client: clientId,
    vehicle: vehicleId,
    startDate,
    endDate,
  });

  res.status(201).json({
    success: true,
    data: rental,
  });
});

// @desc    Obtenir l'historique des réservations du client
// @route   GET /api/rentals/my
// @access  Private (Client)
exports.getMyRentals = asyncHandler(async (req, res, next) => {
  const rentals = await Rental.find({ client: req.user.id }).populate({
    path: 'vehicle',
    select: 'name price images owner',
  });
  res.status(200).json({
    success: true,
    count: rentals.length,
    data: rentals,
  });
});

// @desc    Obtenir les réservations pour les véhicules d'un locateur
// @route   GET /api/rentals/my-rentals
// @access  Private (Locateur)
exports.getRentalsForMyVehicles = asyncHandler(async (req, res, next) => {
  const vehicles = await Vehicle.find({ owner: req.user.id }).select('_id');
  const vehicleIds = vehicles.map((v) => v._id);

  const rentals = await Rental.find({ vehicle: { $in: vehicleIds } }).populate([
    { path: 'client', select: 'name email' },
    { path: 'vehicle', select: 'name price' },
  ]);

  res.status(200).json({
    success: true,
    count: rentals.length,
    data: rentals,
  });
});

// @desc    Mettre à jour le statut d'une réservation (ex: "confirmée")
// @route   PUT /api/rentals/:id
// @access  Private (Locateur)
exports.updateRentalStatus = asyncHandler(async (req, res, next) => {
  const { status } = req.body;
  let rental = await Rental.findById(req.params.id).populate('vehicle');

  if (!rental) {
    return next(
      new ErrorResponse(
        `Réservation non trouvée avec l'id ${req.params.id}`,
        404
      )
    );
  }

  // S'assurer que le locateur est le propriétaire du véhicule associé à la réservation
  if (rental.vehicle.owner.toString() !== req.user.id) {
    return next(
      new ErrorResponse(
        'Accès non autorisé pour mettre à jour cette réservation',
        403
      )
    );
  }

  rental.status = status;
  await rental.save();

  res.status(200).json({
    success: true,
    data: rental,
  });
});

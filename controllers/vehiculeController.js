const asyncHandler = require('../middleware/asyncHandler');
const ErrorResponse = require('../utils/errorHandler');
const Vehicle = require('../models/Vehicle');
const ImageKit = require('imagekit');

// Configuration d'ImageKit.io
const imagekit = new ImageKit({
  publicKey: process.env.IMAGEKIT_PUBLIC_KEY,
  privateKey: process.env.IMAGEKIT_PRIVATE_KEY,
  urlEndpoint: process.env.IMAGEKIT_URL_ENDPOINT,
});

// @desc    Créer un nouveau véhicule
// @route   POST /api/vehicles
// @access  Private (Locateur)
exports.createVehicle = asyncHandler(async (req, res, next) => {
  // Associer le véhicule à l'utilisateur connecté (le locateur)
  req.body.owner = req.user.id;

  // Gérer l'upload des images (exemple simple)
  // Le frontend enverra les images en base64 ou sous forme de fichier
  const images = req.body.images || [];
  const imageUrls = [];

  for (const image of images) {
    const upload = await imagekit.upload({
      file: image, // Base64 string
      fileName: `vehicle_${Date.now()}.png`,
      folder: 'location_vehicules/vehicles',
    });
    imageUrls.push({ url: upload.url, fileId: upload.fileId });
  }

  req.body.images = imageUrls;

  const vehicle = await Vehicle.create(req.body);

  res.status(201).json({
    success: true,
    data: vehicle,
  });
});

// @desc    Obtenir les véhicules du locateur connecté
// @route   GET /api/vehicles/my
// @access  Private (Locateur)
exports.getMyVehicles = asyncHandler(async (req, res, next) => {
  const vehicles = await Vehicle.find({ owner: req.user.id });
  res.status(200).json({
    success: true,
    count: vehicles.length,
    data: vehicles,
  });
});

// @desc    Mettre à jour un véhicule
// @route   PUT /api/vehicles/:id
// @access  Private (Locateur)
exports.updateVehicle = asyncHandler(async (req, res, next) => {
  let vehicle = await Vehicle.findById(req.params.id);

  if (!vehicle) {
    return next(
      new ErrorResponse(`Véhicule non trouvé avec l'id ${req.params.id}`, 404)
    );
  }

  // S'assurer que l'utilisateur est bien le propriétaire du véhicule
  if (vehicle.owner.toString() !== req.user.id) {
    return next(
      new ErrorResponse(
        'Accès non autorisé pour la mise à jour de ce véhicule',
        403
      )
    );
  }

  vehicle = await Vehicle.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
  });

  res.status(200).json({
    success: true,
    data: vehicle,
  });
});

// @desc    Supprimer un véhicule
// @route   DELETE /api/vehicles/:id
// @access  Private (Locateur)
exports.deleteVehicle = asyncHandler(async (req, res, next) => {
  const vehicle = await Vehicle.findById(req.params.id);

  if (!vehicle) {
    return next(
      new ErrorResponse(`Véhicule non trouvé avec l'id ${req.params.id}`, 404)
    );
  }

  // S'assurer que l'utilisateur est bien le propriétaire du véhicule
  if (vehicle.owner.toString() !== req.user.id) {
    return next(
      new ErrorResponse(
        'Accès non autorisé pour la suppression de ce véhicule',
        403
      )
    );
  }

  await vehicle.remove();

  res.status(200).json({
    success: true,
    data: {},
  });
});

// @desc    Obtenir tous les véhicules (avec filtres et pagination)
// @route   GET /api/vehicles
// @access  Public
exports.getVehicles = asyncHandler(async (req, res, next) => {
  let query;

  // Créer une copie de req.query
  const reqQuery = { ...req.query };

  // Champs à exclure pour le filtrage
  const removeFields = ['select', 'sort', 'page', 'limit'];

  // Supprimer les champs de reqQuery
  removeFields.forEach((param) => delete reqQuery[param]);

  // Créer la chaîne de requête
  let queryStr = JSON.stringify(reqQuery);

  // Créer des opérateurs ($gt, $gte, etc.)
  queryStr = queryStr.replace(
    /\b(gt|gte|lt|lte|in)\b/g,
    (match) => `$${match}`
  );

  query = Vehicle.find(JSON.parse(queryStr));

  // Champs à sélectionner
  if (req.query.select) {
    const fields = req.query.select.split(',').join(' ');
    query = query.select(fields);
  }

  // Trier
  if (req.query.sort) {
    const sortBy = req.query.sort.split(',').join(' ');
    query = query.sort(sortBy);
  } else {
    query = query.sort('-createdAt');
  }

  // Pagination
  const page = parseInt(req.query.page, 10) || 1;
  const limit = parseInt(req.query.limit, 10) || 25;
  const startIndex = (page - 1) * limit;
  const endIndex = page * limit;
  const total = await Vehicle.countDocuments();

  query = query.skip(startIndex).limit(limit);

  // Exécuter la requête
  const vehicles = await query;

  // Résultat de la pagination
  const pagination = {};

  if (endIndex < total) {
    pagination.next = {
      page: page + 1,
      limit,
    };
  }

  if (startIndex > 0) {
    pagination.prev = {
      page: page - 1,
      limit,
    };
  }

  res.status(200).json({
    success: true,
    count: vehicles.length,
    pagination,
    data: vehicles,
  });
});

// @desc    Obtenir les détails d'un véhicule
// @route   GET /api/vehicles/:id
// @access  Public
exports.getVehicle = asyncHandler(async (req, res, next) => {
  const vehicle = await Vehicle.findById(req.params.id);

  if (!vehicle) {
    return next(
      new ErrorResponse(`Véhicule non trouvé avec l'id ${req.params.id}`, 404)
    );
  }

  res.status(200).json({
    success: true,
    data: vehicle,
  });
});

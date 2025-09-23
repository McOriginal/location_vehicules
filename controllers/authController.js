const asyncHandler = require('../middleware/asyncHandler');
const ErrorResponse = require('../utils/errorHandler');
const User = require('../models/User');

// Générer le JWT et l'envoyer
const sendTokenResponse = (user, statusCode, res) => {
  const token = user.getSignedJwtToken();
  res.status(statusCode).json({
    success: true,
    token,
  });
};

// @desc    Enregistrer un utilisateur
// @route   POST /api/auth/register
// @access  Public
exports.register = asyncHandler(async (req, res, next) => {
  const { name, email, password, role } = req.body;

  if (!name || !email || !password) {
    return next(
      new ErrorResponse(
        'Veuillez fournir un nom, un email et un mot de passe',
        400
      )
    );
  }

  // Créer un utilisateur
  const user = await User.create({
    name,
    email,
    password,
    role,
  });

  sendTokenResponse(user, 201, res);
});

// @desc    Se connecter
// @route   POST /api/auth/login
// @access  Public
exports.login = asyncHandler(async (req, res, next) => {
  const { email, password } = req.body;

  // Valider l'email et le mot de passe
  if (!email || !password) {
    return next(
      new ErrorResponse('Veuillez fournir un email et un mot de passe', 400)
    );
  }

  // Vérifier l'utilisateur
  const user = await User.findOne({ email }).select('+password');

  if (!user) {
    return next(new ErrorResponse('Identifiants invalides', 401));
  }

  // Vérifier le mot de passe
  const isMatch = await user.matchPassword(password);

  if (!isMatch) {
    return next(new ErrorResponse('Identifiants invalides', 401));
  }

  sendTokenResponse(user, 200, res);
});

// @desc    Obtenir le profil de l'utilisateur
// @route   GET /api/auth/profile
// @access  Private
exports.getProfile = asyncHandler(async (req, res, next) => {
  const user = await User.findById(req.user.id);
  res.status(200).json({
    success: true,
    data: user,
  });
});

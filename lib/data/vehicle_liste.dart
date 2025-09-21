import 'package:location_vehicules/data/models/vehicle_model.dart';

List<VehicleModel> vehicleList = [
  VehicleModel(
    name: 'Toyota Camry',
    description: 'voiture de mariage pour les mariés avec un chauffeur.',
    type: 'Sedan',
    price: 700,
    images: ['car1.png', 'car2.png'],
    isAvailable: true,
    color: 'Blue',
    categories: ['mariage', 'voyage'],
  ),
  VehicleModel(
    name: 'Honda CR-V',
    description: 'voiture de mariage pour les mariés avec un chauffeur.',
    type: 'SUV',
    price: 1000,
    images: ['car3.png', 'car2.png'],
    isAvailable: true,
    color: 'Red',
    categories: ['mariage', 'aventure'],
  ),
  VehicleModel(
    name: 'Ford Mustang',
    description:
        'voiture de personnel pour vos deplacement au travail, ou des voyages.',
    type: 'Coupe',
    price: 1200,
    images: ['car3.png', 'car1.png'],
    isAvailable: false,
    color: 'Black',
    categories: ['business', 'voyage'],
  ),
  VehicleModel(
    name: 'Chevrolet Tahoe',
    description: 'voiture de mariage pour les mariés avec un chauffeur.',
    type: 'SUV',
    price: 9500,
    images: ['car1.png', 'car3.png'],
    isAvailable: true,
    color: 'White',
    categories: ['mariage', 'famille'],
  ),
];

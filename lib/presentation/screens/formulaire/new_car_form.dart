import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_responsive.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';
import 'package:location_vehicules/presentation/widgets/button.dart';

class NewCarForm extends StatefulWidget {
  const NewCarForm({super.key});

  @override
  State<NewCarForm> createState() => _NewCarFormState();
}

class _NewCarFormState extends State<NewCarForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  bool _isAvailableController = true;
  List<File> _selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();
  final int maxImages = 5;
  final double maxSizeMB = 2;

  Future<void> _onPickImage() async {
    final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage(
      imageQuality: 70, // compression de base
      maxWidth: 800, // redimensionne
    );

    if (pickedFiles == null) return;

    List<File> validFiles = [];

    for (var file in pickedFiles) {
      final f = File(file.path);
      final sizeInMB = f.lengthSync() / (1024 * 1024);

      if (sizeInMB <= maxSizeMB) {
        validFiles.add(f);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("${file.name} dépasse 2 Mo")));
      }
    }

    // Limite du nombre d’images
    if (_selectedImages.length + validFiles.length > maxImages) {
      final allowed = maxImages - _selectedImages.length;
      validFiles = validFiles.take(allowed).toList();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vous ne pouvez choisir que $maxImages images")),
      );
    }

    setState(() {
      _selectedImages.addAll(validFiles);
    });
  }

  void _submitForm() {}
  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------
    final responsive = AppResponsive(context);
    // ----------------------------------------------
    return Scaffold(
      backgroundColor: AppColors.whiteSecondary,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: responsive.hp(0.02),
                  bottom: responsive.hp(0.02),
                  left: responsive.hp(0.02),
                ),
                child: backButton(context),
              ),
              Text(
                "Ajouter une nouvelle voiture",
                style: AppTextStyles.title.copyWith(
                  fontSize: responsive.sp(18),
                  color: AppColors.blackPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Nom de la voiture",
                          labelStyle: AppTextStyles.title.copyWith(
                            color: AppColors.blackSecondary,
                            fontSize: 14,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          filled: true,
                          fillColor: AppColors.whiteSecondary,
                          focusColor: AppColors.secondary,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.secondary),
                          ),
                          prefixIcon: const Icon(
                            Icons.directions_car,
                            color: AppColors.blackPrimary,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _typeController,
                        decoration: InputDecoration(
                          labelText: "Model de la voiture",
                          labelStyle: AppTextStyles.title.copyWith(
                            color: AppColors.blackSecondary,
                            fontSize: 14,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          filled: true,
                          fillColor: AppColors.whiteSecondary,
                          focusColor: AppColors.secondary,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.secondary),
                          ),
                          prefixIcon: const Icon(
                            Icons.car_rental,
                            color: AppColors.blackPrimary,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Prix par heure",
                          labelStyle: AppTextStyles.title.copyWith(
                            color: AppColors.blackSecondary,
                            fontSize: 14,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          filled: true,
                          fillColor: AppColors.whiteSecondary,
                          focusColor: AppColors.secondary,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.secondary),
                          ),
                          prefixIcon: const Icon(
                            Icons.attach_money,
                            color: AppColors.blackPrimary,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Categorie en dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Catégorie",
                          labelStyle: AppTextStyles.title.copyWith(
                            color: AppColors.blackSecondary,
                            fontSize: 14,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          filled: true,
                          fillColor: AppColors.whiteSecondary,
                          focusColor: AppColors.secondary,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.secondary),
                          ),
                          prefixIcon: const Icon(
                            Icons.category,
                            color: AppColors.blackPrimary,
                            size: 25,
                          ),
                        ),
                        items:
                            [
                                  'Tous',
                                  'Particulier',
                                  'Evènnement spécial'
                                      'Business',
                                  'Activité Professionnelle',
                                  'Voyage',
                                ]
                                .map(
                                  (cat) => DropdownMenuItem<String>(
                                    value: cat,
                                    child: Text(
                                      cat,
                                      style: AppTextStyles.title.copyWith(
                                        color: AppColors.blackPrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (item) {
                          _categoryController.text = item!;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _colorController,
                        decoration: InputDecoration(
                          labelText: "Couleur de la voiture",
                          labelStyle: AppTextStyles.title.copyWith(
                            color: AppColors.blackSecondary,
                            fontSize: 14,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          filled: true,
                          fillColor: AppColors.whiteSecondary,
                          focusColor: AppColors.secondary,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.secondary),
                          ),
                          prefixIcon: const Icon(
                            Icons.color_lens,
                            color: AppColors.blackPrimary,
                            size: 25,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Une petite Description de la voiture",
                          labelStyle: AppTextStyles.title.copyWith(
                            color: AppColors.blackSecondary.withOpacity(0.6),
                            fontSize: 14,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          filled: true,
                          fillColor: AppColors.whiteSecondary,
                          focusColor: AppColors.secondary,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.secondary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Disponibilité
                      Row(
                        children: [
                          Expanded(
                            child: SwitchListTile(
                              title: Text(
                                "Disponibilité",
                                style: AppTextStyles.title.copyWith(
                                  color: AppColors.blackSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              value: _isAvailableController,
                              onChanged: (value) {
                                setState(() {
                                  _isAvailableController = value;
                                });
                              },
                              activeColor: AppColors.primary,
                              inactiveThumbColor: AppColors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Text(
                              _isAvailableController
                                  ? "Disponible"
                                  : "Indisponible",
                              style: AppTextStyles.title.copyWith(
                                color: _isAvailableController
                                    ? AppColors.primary
                                    : AppColors.blackSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Selection des images
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _onPickImage,
                                  icon: const Icon(Icons.photo_library),
                                  label: const Text(
                                    "Sélectionner (1 à 5) images",
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary,
                                    foregroundColor: AppColors.whitePrimary,
                                  ),
                                ),
                              ),
                              _selectedImages.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedImages = [];
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        size: 22,
                                        color: AppColors.whitePrimary,
                                      ),
                                      style: IconButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        elevation: 2,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),

                          const SizedBox(height: 10),
                          SizedBox(
                            height: responsive.hp(0.2),
                            width: double.infinity,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.blackSecondary,
                                ),
                              ),
                              child: _selectedImages.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Aucune image sélectionnée",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.content.copyWith(
                                          color: AppColors.primary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _selectedImages.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                    _selectedImages[index],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedImages.removeAt(
                                                      index,
                                                    );
                                                  });
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Colors.black54,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color:
                                                        AppColors.whitePrimary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),

                      // Bouton de Validation
                      InkWell(
                        onTap: _submitForm,
                        child: Container(
                          margin: EdgeInsets.only(top: responsive.wp(0.07)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ajouter la voiture',
                                style: AppTextStyles.title.copyWith(
                                  fontSize: responsive.sp(16),
                                  color: AppColors.whitePrimary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.check,
                                size: 25,
                                color: AppColors.whitePrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

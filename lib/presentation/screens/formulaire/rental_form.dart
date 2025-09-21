import 'package:flutter/material.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_responsive.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';

class RentalForm extends StatefulWidget {
  final String vehicleId; // reçu depuis la page VehicleDetails
  const RentalForm({super.key, required this.vehicleId});

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _pickupController = TextEditingController();
  final _motifController = TextEditingController();

  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  Future<void> _onSelectedEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endDateController.text = picked.toString().substring(0, 10);
      });
    }
  }

  Future<void> _onSelectedStartDate() async {
    final DateTime? pickStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickStartDate != null) {
      setState(() {
        _startDateController.text = pickStartDate.toString().substring(0, 10);
        ;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_endDateController.text.isNotEmpty) {
        DateTime endDate = DateTime.parse(_endDateController.text);
        if (DateTime.parse(_startDateController.text).isAfter(endDate)) {
          // Si la date de début est après la date de fin, réinitialiser la date de fin
          // _endDateController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primary,
              content: Text(
                'La date de fin doit être après la date de début.',
                textAlign: TextAlign.center,
                style: AppTextStyles.content,
              ),
            ),
          );
        }
      }
      print("Réservation envoyée :");
      print("Nom : ${_nameController.text}");
      print("Téléphone : ${_phoneController.text}");
      print("Email : ${_emailController.text}");
      print("Pickup : ${_pickupController.text}");
      print("Dropoff : ${_motifController.text}");
      print("StartDate : ${_startDateController.text}");
      print("EndDate : ${_endDateController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // -----------------------------------------
    final responsive = AppResponsive(context);
    // -----------------------------------------
    return Scaffold(
      backgroundColor: AppColors.whiteSecondary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: responsive.hp(0.06)),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Formulaire de Réservation',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 24,
                          color: AppColors.blackPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Nom
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        fillColor: AppColors.secondary,
                        labelText: "Nom Complet",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: AppColors.secondary,
                        ),
                      ),
                      validator: (val) =>
                          val == null || val.isEmpty ? "Nom requis" : null,
                    ),
                    const SizedBox(height: 15),

                    // Téléphone
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        fillColor: AppColors.secondary,
                        labelText: "Numéro de Téléphone",
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: AppColors.secondary,
                        ),
                      ),
                      validator: (val) => val == null || val.isEmpty
                          ? "Téléphone requis"
                          : null,
                    ),
                    const SizedBox(height: 15),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        fillColor: AppColors.secondary,
                        labelText: "Adresse Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.secondary,
                        ),
                      ),
                      validator: (val) => val != null && val.contains("@")
                          ? null
                          : "Email invalide",
                    ),
                    const SizedBox(height: 20),
                    // Adresse
                    TextFormField(
                      controller: _pickupController,
                      decoration: const InputDecoration(
                        fillColor: AppColors.secondary,
                        labelText: "Votre adresse domicile",
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Date début
                    TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        fillColor: AppColors.secondary,
                        labelText: "Date de début",
                        prefixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.secondary,
                        ),
                      ),
                      onTap: _onSelectedStartDate,
                    ),
                    const SizedBox(height: 30),

                    // Date fin
                    TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        fillColor: AppColors.secondary,
                        labelText: "Date de fin",
                        prefixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.secondary,
                        ),
                      ),
                      onTap: _onSelectedEndDate,
                    ),

                    const SizedBox(height: 15),

                    // Motif de Reservation en Liste déroulante
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        fillColor: AppColors.secondary,
                        labelText: "Pour quel raison voulez-vous louer ?",
                        prefixIcon: Icon(
                          Icons.event_note_outlined,
                          color: AppColors.secondary,
                        ),
                      ),
                      items:
                          [
                                'Voyage',
                                'Travail',
                                'Déplacement professionnel',
                                'Événement spécial',
                                'Essai avant achat',
                                'Visite familiale',
                                'Loisir',
                                'Autre',
                              ]
                              .map(
                                (motif) => DropdownMenuItem<String>(
                                  value: motif,
                                  child: Text(
                                    motif,
                                    style: AppTextStyles.content.copyWith(
                                      color: AppColors.blackSecondary,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        _motifController.text = val ?? '';
                      },
                      validator: (val) =>
                          val == null || val.isEmpty ? "Motif requis" : null,
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 35),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _formKey.currentState?.reset();
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      margin: EdgeInsets.zero,
                      child: Text(
                        'Annuler',
                        style: AppTextStyles.title.copyWith(
                          fontSize: responsive.sp(14),
                          color: AppColors.whitePrimary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: _submitForm,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Reservez Maintenant',
                              style: AppTextStyles.title.copyWith(
                                fontSize: responsive.sp(16),
                                color: AppColors.whitePrimary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.event_available,
                              size: 25,
                              color: AppColors.whitePrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

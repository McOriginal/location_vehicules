import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_vehicules/presentation/animations/page_view_animation.dart';
import 'package:location_vehicules/presentation/screens/formulaire/rental_form.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_responsive.dart';
import 'package:location_vehicules/data/models/vehicle_model.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';
import 'package:location_vehicules/presentation/widgets/button.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({super.key, required this.selectedVehicle});
  final VehicleModel selectedVehicle;
  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  // -----------------Variable------------------------------
  int selectedVehicleImageIndex = 0;
  late final PageController _pageController;
  // -----------------Variable------------------------------
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedVehicleImageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------
    final vehicle = widget.selectedVehicle;
    final responsive = AppResponsive(context);
    // ----------------------------------------------------
    return Scaffold(
      backgroundColor: AppColors.blackPrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
            bottom: responsive.hp(0.1),
          ),
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      height: responsive.hp(0.4),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.whiteSecondary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(
                                    () => selectedVehicleImageIndex = index,
                                  );
                                },
                                itemCount: vehicle.images.length,
                                itemBuilder: (context, index) {
                                  return Image(
                                    image: AssetImage(
                                      'assets/images/${vehicle.images[index]}',
                                    ),
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: backButton(context),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(vehicle.images.length, (
                                index,
                              ) {
                                final isActive =
                                    index == selectedVehicleImageIndex;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: isActive ? 10 : 8,
                                  height: isActive ? 10 : 8,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? AppColors.primary
                                        : AppColors.blackPrimary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 1,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: responsive.hp(0.015)),
                    SizedBox(
                      height: responsive.hp(0.11),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(0.03),
                        ),
                        itemBuilder: (context, index) {
                          final isSelected = index == selectedVehicleImageIndex;
                          return GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                              setState(() => selectedVehicleImageIndex = index);
                            },
                            child: Container(
                              width: responsive.wp(0.25),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                // color: AppColors.whiteSecondary,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.whitePrimary
                                      : AppColors.whiteSecondary,
                                  width: isSelected ? 3 : 0.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/${vehicle.images[index]}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) =>
                            SizedBox(width: responsive.wp(0.02)),
                        itemCount: vehicle.images.length,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(vehicle.name, style: AppTextStyles.title),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 35,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Text("Détails de Véhicule", style: AppTextStyles.title),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.card_giftcard,
                                    size: 22,
                                    color: AppColors.whitePrimary,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Type: ${vehicle.type}',
                                    style: AppTextStyles.content,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.color_lens,
                                    size: 22,
                                    color: AppColors.whitePrimary,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Couleur: ${vehicle.color}',
                                    style: AppTextStyles.content,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.attach_money,
                                    size: 22,
                                    color: AppColors.whitePrimary,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Prix: ${vehicle.price} f / H',
                                    style: AppTextStyles.content,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.verified,
                                    size: 22,
                                    color: AppColors.whitePrimary,
                                  ),
                                ),
                                Text(
                                  vehicle.isAvailable
                                      ? 'Disponible'
                                      : 'Indisponible',
                                  style: AppTextStyles.content,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.category,
                          size: 22,
                          color: AppColors.whitePrimary,
                        ),
                      ),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: vehicle.categories.map((cat) {
                            return Chip(
                              label: Text(
                                cat.toUpperCase(),
                                style: AppTextStyles.title.copyWith(
                                  color: AppColors.whitePrimary,
                                  fontSize: responsive.sp(15),
                                ),
                              ),
                              backgroundColor: AppColors.secondary,
                              shape: const StadiumBorder(
                                side: BorderSide(color: AppColors.whitePrimary),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Text("Prix", style: AppTextStyles.title),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 4,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.whitePrimary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Heure',
                                style: AppTextStyles.title.copyWith(
                                  fontSize: responsive.sp(12),
                                ),
                              ),
                              Text(
                                '${vehicle.price.toString()} f',
                                style: AppTextStyles.content.copyWith(
                                  fontSize: responsive.sp(11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 4,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.whitePrimary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Jour',
                                style: AppTextStyles.title.copyWith(
                                  fontSize: responsive.sp(12),
                                ),
                              ),
                              Text(
                                '${vehicle.price * 24} f',
                                style: AppTextStyles.content.copyWith(
                                  fontSize: responsive.sp(11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 4,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.whitePrimary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Semaine',
                                style: AppTextStyles.title.copyWith(
                                  fontSize: responsive.sp(12),
                                ),
                              ),
                              Text(
                                '${vehicle.price * 45} f',
                                style: AppTextStyles.content.copyWith(
                                  fontSize: responsive.sp(11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 4,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.whitePrimary,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mois',
                                style: AppTextStyles.title.copyWith(
                                  fontSize: responsive.sp(12),
                                ),
                              ),
                              Text(
                                '${vehicle.price * 60} f',
                                style: AppTextStyles.content.copyWith(
                                  fontSize: responsive.sp(11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: responsive.hp(0.05)),
              Text("Propriétaire", style: AppTextStyles.title),
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person_2_outlined,
                        size: 18,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Mohamed Cissé".toUpperCase(),
                        style: AppTextStyles.content,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.house_outlined,
                        size: 18,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Cissé Auto".toUpperCase(),
                        style: AppTextStyles.content,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.map_outlined,
                        size: 18,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text("Bacodjicoroni Golf", style: AppTextStyles.content),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        size: 18,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text("72 14 23 29", style: AppTextStyles.content),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.whatsapp,
                      size: 22,
                      color: AppColors.whitePrimary,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(width: responsive.wp(0.1)),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tiktok_outlined,
                      size: 22,
                      color: AppColors.whitePrimary,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.blackSecondary,
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(width: responsive.wp(0.1)),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_forwarded,
                      size: 22,
                      color: AppColors.whitePrimary,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF007AFF),
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              screenViewAnimation(
                builder: (context) => RentalForm(vehicleId: vehicle.name),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            width: responsive.wp(0.7),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Faire une Reservation',
                  style: AppTextStyles.title.copyWith(
                    fontSize: responsive.sp(16),
                    color: AppColors.whitePrimary,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.event_available,
                  size: 35,
                  color: AppColors.whitePrimary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_responsive.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';
import 'package:location_vehicules/data/category_liste.dart';
import 'package:location_vehicules/data/vehicle_liste.dart';
import 'package:location_vehicules/presentation/animations/page_view_animation.dart';
import 'package:location_vehicules/presentation/screens/vehicle_details.dart';

class HomeCarListe extends StatefulWidget {
  const HomeCarListe({super.key});

  @override
  State<HomeCarListe> createState() => _HomeCarListeState();
}

class _HomeCarListeState extends State<HomeCarListe> {
  int selectedCategoriIndex = 0;
  @override
  Widget build(BuildContext context) {
    // ------------------------------------------------------
    final responsive = AppResponsive(context);
    // ----------------------------------------------------------
    return Scaffold(
      backgroundColor: AppColors.blackPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Rounded search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher une voiture',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.whitePrimary,
                  ),
                ),
              ),
              SizedBox(height: responsive.sp(10)),
              // Categories Liste
              Container(
                height: 50,
                color: AppColors.whitePrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(0.05),
                  vertical: 5,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vehicleCategories.length,
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  itemBuilder: (context, index) {
                    final category = vehicleCategories[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategoriIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: responsive.wp(0.05)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 20,
                        decoration: BoxDecoration(
                          color: selectedCategoriIndex == index
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selectedCategoriIndex == index
                                ? AppColors.blackPrimary
                                : Colors.transparent,
                            width: 1,
                          ),
                          boxShadow: selectedCategoriIndex == index
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF000000,
                                    ).withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 0.2,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              category.icon,
                              size: responsive.sp(25),
                              color: selectedCategoriIndex == index
                                  ? AppColors.whitePrimary
                                  : AppColors.blackSecondary,
                            ),
                            SizedBox(width: responsive.hp(0.01)),
                            Text(
                              category.title,
                              style: AppTextStyles.title.copyWith(
                                fontSize: responsive.sp(12),
                                fontWeight: selectedCategoriIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectedCategoriIndex == index
                                    ? AppColors.whitePrimary
                                    : AppColors.blackSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Voitures Liste
              SizedBox(height: responsive.sp(2)),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                child: GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: responsive.hp(0.02),
                    crossAxisSpacing: responsive.wp(0.02),
                    childAspectRatio: 0.7,
                  ),
                  itemCount: vehicleList.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicleList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.blackSecondary,
                        borderRadius: BorderRadius.circular(
                          responsive.wp(0.02),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              125,
                              125,
                              125,
                            ).withOpacity(0.5),
                            blurRadius: 5,
                            spreadRadius: 0.2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/images/${vehicle.images[0]}',
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: responsive.wp(0.2),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.secondary,
                                      size: responsive.wp(0.05),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.secondary,
                                      size: responsive.wp(0.05),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.secondary,
                                      size: responsive.wp(0.05),
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: AppColors.secondary,
                                      size: responsive.wp(0.05),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: AppColors.primary,
                                    size: responsive.wp(0.05),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(responsive.wp(0.02)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: responsive.wp(0.5),
                                      child: Text(
                                        vehicle.name,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.title.copyWith(
                                          fontSize: responsive.sp(14),
                                          color: AppColors.whitePrimary,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: responsive.wp(0.5),
                                      child: Text(
                                        vehicle.categories[0],
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.content.copyWith(
                                          fontSize: responsive.sp(12),
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteSecondary,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: responsive.hp(0.01)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${vehicle.price.toString()} F',
                                              style: AppTextStyles.title
                                                  .copyWith(
                                                    fontSize: responsive.sp(14),
                                                    color: AppColors.secondary,
                                                  ),
                                            ),
                                            Text(
                                              ' / h',
                                              style: AppTextStyles.title
                                                  .copyWith(
                                                    fontSize: responsive.sp(14),
                                                    color: AppColors
                                                        .whiteSecondary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        vehicle.isAvailable
                                            ? Icon(
                                                Icons.check_circle,
                                                color: AppColors.green,
                                                size: responsive.wp(0.05),
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: AppColors.primary,
                                                size: responsive.wp(0.05),
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: responsive.hp(0.02)),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            screenViewAnimation(
                                              builder: (context) =>
                                                  VehicleDetails(
                                                    selectedVehicle: vehicle,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Voir plus',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.title
                                                  .copyWith(
                                                    fontSize: responsive.sp(12),
                                                    color:
                                                        AppColors.whitePrimary,
                                                  ),
                                            ),
                                          ),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

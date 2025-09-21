import 'package:flutter/material.dart';
import 'package:location_vehicules/presentation/animations/page_view_animation.dart';
import 'package:location_vehicules/presentation/screens/formulaire/new_car_form.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_responsive.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ------------------------------------------------
    final responsive = AppResponsive(context);
    // ------------------------------------------------
    return Scaffold(
      backgroundColor: AppColors.blackPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: responsive.hp(0.3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage('assets/images/car1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      AppColors.whiteSecondary.withOpacity(0.8),
                      AppColors.whiteSecondary.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  screenViewAnimation(builder: (context) => const NewCarForm()),
                );
              },
              label: Text(
                "Ajouter une voiture",
                style: AppTextStyles.title.copyWith(
                  fontSize: responsive.sp(17),
                ),
              ),
              icon: const Icon(
                Icons.add,
                size: 28,
                color: AppColors.whitePrimary,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(0.1),
                  vertical: responsive.hp(0.02),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

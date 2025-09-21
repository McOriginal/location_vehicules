import 'package:flutter/material.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';

class HistoriqueScreen extends StatelessWidget {
  const HistoriqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              color: AppColors.grey,
              child: const Center(
                child: Text(
                  'Historique des locations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10, // Nombre d'éléments dans l'historique
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.directions_car,
                    color: AppColors.secondary,
                  ),
                  title: Text(
                    'Location ${index + 1}',
                    style: AppTextStyles.title,
                  ),
                  subtitle: Text(
                    'Détails de la location ${index + 1}',
                    style: AppTextStyles.content,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.secondary,
                  ),
                  onTap: () {
                    // Action lors du clic sur un élément de l'historique
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

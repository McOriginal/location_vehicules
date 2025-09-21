import 'package:flutter/material.dart';
import 'package:location_vehicules/data/models/hom_bottom_navigation_bar.dart';
import 'package:location_vehicules/presentation/screens/favorite_screen.dart';
import 'package:location_vehicules/presentation/screens/historique_screen.dart';
import 'package:location_vehicules/presentation/screens/home_car_liste.dart';
import 'package:location_vehicules/presentation/screens/profile_screen.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_responsive.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedPageIndex = 0;
  late PageController _pageController;

  List<BottomNavigationItem> bottomNavigationItems = [
    BottomNavigationItem(
      label: 'Accueil',
      icon: Icons.home,
      page: const HomeCarListe(),
    ),
    BottomNavigationItem(
      label: 'Favoris',
      icon: Icons.favorite,
      page: const FavoriteScreen(),
    ),
    BottomNavigationItem(
      label: 'Historique',
      icon: Icons.history,
      page: const HistoriqueScreen(),
    ),
    BottomNavigationItem(
      label: 'Profil',
      icon: Icons.person,
      page: const ProfileScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = AppResponsive(context);

    return Scaffold(
      backgroundColor: AppColors.blackPrimary,
      body: PageView(
        controller: _pageController,
        children: bottomNavigationItems.map((e) => e.page).toList(),
        onPageChanged: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.blackSecondary,
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: AppColors.whitePrimary,
        selectedLabelStyle: AppTextStyles.title.copyWith(
          color: AppColors.secondary,
          fontSize: responsive.sp(14),
        ),
        unselectedLabelStyle: AppTextStyles.content.copyWith(
          color: AppColors.whiteSecondary,
          fontSize: responsive.sp(12),
        ),
        currentIndex: selectedPageIndex,
        onTap: (index) {
          _pageController.jumpToPage(index); // 👈 synchronisation avec PageView
        },
        items: bottomNavigationItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

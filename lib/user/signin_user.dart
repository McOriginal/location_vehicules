import 'package:flutter/material.dart';
import 'package:location_vehicules/presentation/animations/page_view_animation.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';
import 'package:location_vehicules/presentation/widgets/app_responsive.dart';
import 'package:location_vehicules/presentation/widgets/app_text_styles.dart';
import 'package:location_vehicules/user/login_user.dart';

class SigninUser extends StatefulWidget {
  const SigninUser({super.key});

  @override
  State<SigninUser> createState() => _SigninUserState();
}

class _SigninUserState extends State<SigninUser> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isActivePassword = true;
  @override
  Widget build(BuildContext context) {
    // -------------------------------------------
    final responsive = AppResponsive(context);
    // -------------------------------------------
    return Scaffold(
      backgroundColor: AppColors.whiteSecondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: responsive.hp(0.07),
                  bottom: responsive.hp(0.05),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Créer un Compte",
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.blackSecondary,
                  ),
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: "Votre Nom Complet",
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
                          Icons.person,
                          color: AppColors.blackPrimary,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: "Nom de votre Société",
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
                          Icons.business,
                          color: AppColors.blackPrimary,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _adresseController,
                      decoration: InputDecoration(
                        labelText: "Adresse",
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
                          Icons.location_on,
                          color: AppColors.blackPrimary,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Numéro de Téléphone",
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
                          Icons.phone,
                          color: AppColors.blackPrimary,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Adresse Email",
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
                          Icons.email_outlined,
                          color: AppColors.blackPrimary,
                          size: 25,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: isActivePassword,
                      decoration: InputDecoration(
                        labelText: "Mot de Passe",
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
                          Icons.lock,
                          color: AppColors.blackPrimary,
                          size: 25,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isActivePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.blackPrimary,
                            size: 25,
                          ),
                          onPressed: () {
                            setState(() {
                              isActivePassword = !isActivePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Vous avez déjà un compte ?",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.content.copyWith(
                            color: AppColors.blackSecondary.withValues(
                              alpha: 0.5,
                            ),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              screenViewAnimation(
                                curve: Curves.elasticOut,
                                duration: Duration(milliseconds: 2000),
                                builder: (context) => const LoginUser(),
                              ),
                            );
                          },
                          child: Text(
                            "Seconnecter",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title.copyWith(
                              color: AppColors.secondary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Action à effectuer lors du clic sur le bouton
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Créer un Compte",
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.whiteSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Ou",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.blackSecondary.withValues(alpha: 0.5),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Action à effectuer lors du clic sur le bouton
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/google_icon.png',
                                ),
                                width: 40,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Continuer avec Google",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.title.copyWith(
                                  color: AppColors.blackSecondary.withValues(
                                    alpha: 0.5,
                                  ),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }
}

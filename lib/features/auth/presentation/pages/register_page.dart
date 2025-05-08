import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../services/notification_service.dart';
import '../bloc/auth_bloc.dart';
import '../../../../shared/widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomsController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscurePasswordConfirmation = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nomController.dispose();
    _prenomsController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    }
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(value)) {
      return 'Le mot de passe doit contenir au moins une lettre et un chiffre';
    }
    return null;
  }

  String? _validatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'La confirmation du mot de passe est requise';
    }
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }
    if (value.length < 2) {
      return 'Ce champ doit contenir au moins 2 caractères';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            NotificationService.showSnackBar(
              context: context,
              message: state.message,
              type: NotificationType.error,
            );
          } else if (state is AuthAuthenticated) {
            NotificationService.showSnackBar(
              context: context,
              message: 'Inscription réussie',
              type: NotificationType.success,
            );
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nomController,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    validator: _validateName,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _prenomsController,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    validator: _validateName,
                    decoration: InputDecoration(
                      labelText: 'Prénoms',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _passwordConfirmationController,
                    obscureText: _obscurePasswordConfirmation,
                    textInputAction: TextInputAction.done,
                    validator: _validatePasswordConfirmation,
                    decoration: InputDecoration(
                      labelText: 'Confirmer le mot de passe',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePasswordConfirmation
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePasswordConfirmation =
                                !_obscurePasswordConfirmation;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'S\'inscrire',
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  RegisterRequested(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                    passwordConfirmation:
                                        _passwordConfirmationController.text,
                                    nom: _nomController.text.trim(),
                                    prenoms: _prenomsController.text.trim(),
                                  ),
                                );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Déjà un compte ? Connectez-vous',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

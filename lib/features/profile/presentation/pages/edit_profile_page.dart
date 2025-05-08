import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/auth/domain/entities/user_profile.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../services/notification_service.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomController;
  late final TextEditingController _prenomsController;
  late final TextEditingController _disciplineController;
  late final TextEditingController _niveauController;
  late final TextEditingController _villeController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.user.nom);
    _prenomsController = TextEditingController(text: widget.user.prenoms);
    _disciplineController =
        TextEditingController(text: widget.user.discipline ?? '');
    _niveauController = TextEditingController(text: widget.user.niveau ?? '');
    _villeController = TextEditingController(text: widget.user.ville ?? '');
    _bioController = TextEditingController(text: widget.user.bio ?? '');
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomsController.dispose();
    _disciplineController.dispose();
    _niveauController.dispose();
    _villeController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final authBloc = BlocProvider.of<AuthBloc>(context);

      authBloc.add(
        UpdateProfileRequested(
          nom: _nomController.text,
          prenoms: _prenomsController.text,
          bio: _bioController.text,
          discipline: _disciplineController.text,
          niveau: _niveauController.text,
          ville: _villeController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le profil'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            NotificationService.showSnackBar(
              context: context,
              message: 'Profil mis à jour avec succès',
              type: NotificationType.success,
            );
            Navigator.pop(context);
          } else if (state is AuthError) {
            NotificationService.showSnackBar(
              context: context,
              message: state.message,
              type: NotificationType.error,
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: widget.user.avatar != null
                          ? NetworkImage(widget.user.avatar!)
                          : null,
                      child: widget.user.avatar == null
                          ? Icon(Icons.person, size: 50.r)
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Implémenter le changement d'avatar
                        NotificationService.showSnackBar(
                          context: context,
                          message: 'Fonctionnalité à venir',
                          type: NotificationType.info,
                        );
                      },
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Changer la photo de profil'),
                    ),
                    SizedBox(height: 24.h),
                    TextFormField(
                      controller: _prenomsController,
                      decoration: InputDecoration(
                        labelText: 'Prénom(s)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre prénom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _bioController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _disciplineController,
                      decoration: InputDecoration(
                        labelText: 'Discipline',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _niveauController,
                      decoration: InputDecoration(
                        labelText: 'Niveau',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: _villeController,
                      decoration: InputDecoration(
                        labelText: 'Ville',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    CustomButton(
                      text: 'Enregistrer',
                      onPressed: _saveProfile,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

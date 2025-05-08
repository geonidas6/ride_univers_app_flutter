import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/auth/domain/entities/user_profile.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../services/notification_service.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            // Créer un UserProfile par défaut si l'utilisateur n'est pas déjà un UserProfile
            UserProfile user;
            try {
              user = state.user as UserProfile;
            } catch (e) {
              // Si le casting échoue, créer un UserProfile par défaut
              user = UserProfile(
                id: state.user.id,
                email: state.user.email,
                nom: state.user.nom,
                prenoms: state.user.prenoms,
                avatar: state.user.avatar,
                bio: state.user.bio,
                friends: state.user.friends,
                friendRequests: state.user.friendRequests,
                blockedUsers: state.user.blockedUsers,
                createdAt: state.user.createdAt,
                updatedAt: state.user.updatedAt,
                discipline: null,
                niveau: null,
                ville: null,
                totalDistance: 0.0,
                batteryLevel: 100,
                darkMode: false,
                settings: null,
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage:
                        user.avatar != null ? NetworkImage(user.avatar!) : null,
                    child: user.avatar == null
                        ? Icon(Icons.person, size: 50.r)
                        : null,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    '${user.prenoms} ${user.nom}',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  _buildInfoCard(
                    context,
                    'Discipline',
                    user.discipline ?? 'Non spécifié',
                    Icons.directions_bike,
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoCard(
                    context,
                    'Niveau',
                    user.niveau ?? 'Non spécifié',
                    Icons.grade,
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoCard(
                    context,
                    'Ville',
                    user.ville ?? 'Non spécifié',
                    Icons.location_city,
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoCard(
                    context,
                    'Distance totale',
                    '${user.totalDistance.toStringAsFixed(1)} km',
                    Icons.timeline,
                  ),
                  SizedBox(height: 32.h),
                  CustomButton(
                    text: 'Modifier le profil',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(user: user),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(icon, size: 24.w),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge,
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

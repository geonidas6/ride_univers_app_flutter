import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import '../../domain/entities/ride.dart';
import '../bloc/ride_bloc.dart';
import '../bloc/ride_state.dart';
import '../bloc/ride_event.dart';
import '../../../../services/notification_service.dart';
import '../../../../services/location_service.dart';

class CreateRidePage extends StatefulWidget {
  const CreateRidePage({super.key});

  @override
  State<CreateRidePage> createState() => _CreateRidePageState();
}

class _CreateRidePageState extends State<CreateRidePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  RideType _selectedType = RideType.road;
  RideDifficulty _selectedDifficulty = RideDifficulty.beginner;
  DateTime _selectedDate = DateTime.now();
  final List<LatLng> _path = [];
  LatLng? _currentPosition;
  bool _isLoading = false;
  late final MapController mapController = MapController.withUserPosition(
    trackUserLocation: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _path.add(position);
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      NotificationService.showSnackBar(
        context: context,
        message: e.toString(),
        type: NotificationType.error,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  double _calculateDistance() {
    return LocationService.calculateDistance(_path);
  }

  Duration _estimateDuration(double distance) {
    // Vitesse moyenne estimée à 20 km/h pour un cycliste amateur
    return LocationService.estimateDuration(distance, 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un trajet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: OSMFlutter(
                    controller: mapController,
                    osmOption: OSMOption(
                      zoomOption: const ZoomOption(
                        initZoom: 14,
                        minZoomLevel: 2,
                        maxZoomLevel: 18,
                        stepZoom: 1.0,
                      ),
                      userTrackingOption: UserTrackingOption(
                        enableTracking: true,
                        unFollowUser: false,
                      ),
                      roadConfiguration: const RoadOption(
                        roadColor: Colors.blue,
                        roadWidth: 5.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocListener<RideBloc, RideState>(
                    listener: (context, state) {
                      if (state is RideCreated) {
                        NotificationService.showSnackBar(
                          context: context,
                          message: 'Trajet créé avec succès',
                          type: NotificationType.success,
                        );
                        Navigator.pop(context);
                      } else if (state is RideError) {
                        NotificationService.showSnackBar(
                          context: context,
                          message: state.message,
                          type: NotificationType.error,
                        );
                      }
                    },
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                labelText: 'Titre',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le titre est requis';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            DropdownButtonFormField<RideType>(
                              value: _selectedType,
                              decoration: InputDecoration(
                                labelText: 'Type de trajet',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              items: RideType.values.map((type) {
                                return DropdownMenuItem(
                                  value: type,
                                  child: Text(type.toString().split('.').last),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedType = value;
                                  });
                                }
                              },
                            ),
                            SizedBox(height: 16.h),
                            DropdownButtonFormField<RideDifficulty>(
                              value: _selectedDifficulty,
                              decoration: InputDecoration(
                                labelText: 'Difficulté',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              items: RideDifficulty.values.map((difficulty) {
                                return DropdownMenuItem(
                                  value: difficulty,
                                  child: Text(
                                      difficulty.toString().split('.').last),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedDifficulty = value;
                                  });
                                }
                              },
                            ),
                            SizedBox(height: 16.h),
                            ListTile(
                              title: const Text('Date de départ'),
                              subtitle: Text(
                                _selectedDate.toString().split('.').first,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(Icons.calendar_today),
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(_selectedDate),
                                  );
                                  if (time != null) {
                                    setState(() {
                                      _selectedDate = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        time.hour,
                                        time.minute,
                                      );
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 24.h),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_path.length < 2) {
                                    NotificationService.showSnackBar(
                                      context: context,
                                      message:
                                          'Veuillez tracer un itinéraire sur la carte',
                                      type: NotificationType.warning,
                                    );
                                    return;
                                  }
                                  final distance = _calculateDistance();
                                  final now = DateTime.now();
                                  context.read<RideBloc>().add(
                                        CreateRide(
                                          Ride(
                                            id: '', // sera généré par le backend
                                            title: _titleController.text,
                                            description:
                                                _descriptionController.text,
                                            distance: distance,
                                            duration:
                                                _estimateDuration(distance),
                                            averageSpeed:
                                                20.0, // vitesse moyenne estimée
                                            maxSpeed:
                                                30.0, // vitesse max estimée
                                            elevation:
                                                0, // à implémenter plus tard
                                            path: _path,
                                            startTime: _selectedDate,
                                            status: RideStatus.planned,
                                            type: _selectedType,
                                            difficulty: _selectedDifficulty,
                                            userId:
                                                '', // sera rempli par le backend
                                            createdAt: now,
                                            updatedAt: now,
                                          ),
                                        ),
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: const Text('Créer le trajet'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

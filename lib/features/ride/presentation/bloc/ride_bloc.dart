import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/ride_repository.dart';
import '../../domain/usecases/create_ride_usecase.dart';
import '../../domain/usecases/get_rides_usecase.dart';
import '../../domain/usecases/get_ride_by_id_usecase.dart';
import 'ride_event.dart';
import 'ride_state.dart';

@injectable
class RideBloc extends Bloc<RideEvent, RideState> {
  final CreateRideUseCase createRideUseCase;
  final GetRidesUseCase getRidesUseCase;
  final GetRideByIdUseCase getRideByIdUseCase;
  final RideRepository repository;

  RideBloc(
    this.createRideUseCase,
    this.getRidesUseCase,
    this.getRideByIdUseCase,
    this.repository,
  ) : super(RideInitial()) {
    on<LoadRides>(_onLoadRides);
    on<LoadRideById>(_onLoadRideById);
    on<CreateRide>(_onCreateRide);
    on<UpdateRide>(_onUpdateRide);
    on<DeleteRide>(_onDeleteRide);
    on<JoinRide>(_onJoinRide);
    on<LeaveRide>(_onLeaveRide);
    on<LikeRide>(_onLikeRide);
    on<UnlikeRide>(_onUnlikeRide);
    on<SearchRides>(_onSearchRides);
  }

  Future<void> _onLoadRides(LoadRides event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await getRidesUseCase();
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (rides) => emit(RidesLoaded(rides)),
    );
  }

  Future<void> _onLoadRideById(
      LoadRideById event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await getRideByIdUseCase(event.id);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (ride) => emit(RideLoaded(ride)),
    );
  }

  Future<void> _onCreateRide(CreateRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await createRideUseCase(event.ride);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (ride) => emit(RideCreated(ride)),
    );
  }

  Future<void> _onUpdateRide(UpdateRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await repository.updateRide(event.ride);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (updatedRide) => emit(RideLoaded(updatedRide)),
    );
  }

  Future<void> _onDeleteRide(DeleteRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await repository.deleteRide(event.rideId);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (_) => emit(RideDeleted()),
    );
  }

  Future<void> _onJoinRide(JoinRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await repository.joinRide(event.rideId);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (_) => emit(RideJoined()),
    );
  }

  Future<void> _onLeaveRide(LeaveRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await repository.leaveRide(event.rideId);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (_) => emit(RideLeft()),
    );
  }

  Future<void> _onLikeRide(LikeRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await repository.likeRide(event.rideId);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (_) => emit(RideLiked()),
    );
  }

  Future<void> _onUnlikeRide(UnlikeRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await repository.unlikeRide(event.rideId);
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (_) => emit(RideUnliked()),
    );
  }

  Future<void> _onSearchRides(
      SearchRides event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await repository.searchRides(
      query: event.query,
      type: event.type,
      difficulty: event.difficulty,
      minDistance: event.minDistance,
      maxDistance: event.maxDistance,
      startDate: event.startDate,
      endDate: event.endDate,
    );
    result.fold(
      (failure) => emit(RideError(failure.toString())),
      (rides) => emit(RidesLoaded(rides)),
    );
  }
}

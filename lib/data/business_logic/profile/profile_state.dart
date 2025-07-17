part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User profile;
  ProfileLoaded(this.profile);
}

class ProfileImageUploading extends ProfileState {}

class ProfileImageUploadingSuccess extends ProfileState {}

class ProfileLoadingError extends ProfileState {
  final String errorMessage;
  ProfileLoadingError(this.errorMessage);
}

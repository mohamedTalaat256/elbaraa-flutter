import 'package:elbaraa/data/business_logic/profile/profile_cubit.dart';
import 'package:elbaraa/data/business_logic/profile/profile_event.dart';
import 'package:elbaraa/data/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthRepository authRepository;

  String? authToken;
  int? userId;

  ProfileBloc(this.authRepository) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is UploadButtonPressed) {
        emit(ProfileImageUploading());
        String fileName = event.image.path.split('/').last;

        print(event.image.path.toString());

        FormData data = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            event.image.path,
            filename: fileName,
          )
        });

        var response = await authRepository.uploadProfileImage(data);

        if (response['status'] == 'success') {
          emit(ProfileImageUploadingSuccess());
        }
      } else if (event is UpdateProfileButtonBressed) {}
    });
  }
}

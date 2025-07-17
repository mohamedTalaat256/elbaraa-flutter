import 'dart:io';

import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadButtonPressed extends ProfileEvent {
  final File image;
  UploadButtonPressed({required this.image});

  @override
  List<Object> get props => [image];
}

class UpdateProfileButtonBressed extends ProfileEvent {
  final File image;
  UpdateProfileButtonBressed({required this.image});

  @override
  List<Object> get props => [image];
}



import 'package:elbaraa/data/models/session.model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class SessionState {}

class SessionInitial extends SessionState {}


class SessionsLoaded extends SessionState {
  final List<Session> sessions;

  SessionsLoaded(this.sessions);

  List<Object> get props => [sessions];
}


class AuthStudentSessionsLoaded extends SessionState {
  final List<Session> sessions;
  AuthStudentSessionsLoaded(this.sessions);
}

 

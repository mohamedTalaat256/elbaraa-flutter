

import 'package:elbaraa/data/models/subscription.model.dart';
import 'package:elbaraa/data/models/user.dart';

class Session {
  final int? id;
  final String? start;
  final String? end;
  final int? subscriptionId;
  final bool? hasChangeRequest;
  final bool? changeRequestApproved;
  final double? rating;
  final String? comment;
  final String? qAnswer;
  final bool? studentConfirm;
  final String? studentConfirmedAt;
  final bool? instructorConfirm;
  final String? instructorConfirmedAt;
  final String? instructorComment;
  final String? joinUrl;
  final String? startUrl;
  final String? meetingId;
  final int? createdBy;
  final int? updatedBy;

  final Subscription? subscription;
  final User? createdByUser;
  final User? updatedByUser;

  Session({
    this.id,
    this.start,
    this.end,
    this.subscriptionId,
    this.hasChangeRequest,
    this.changeRequestApproved,
    this.rating,
    this.comment,
    this.qAnswer,
    this.studentConfirm,
    this.studentConfirmedAt,
    this.instructorConfirm,
    this.instructorConfirmedAt,
    this.instructorComment,
    this.joinUrl,
    this.startUrl,
    this.meetingId,
    this.createdBy,
    this.updatedBy,
    this.subscription,
    this.createdByUser,
    this.updatedByUser,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      start: json['start'],
      end: json['end'],
      subscriptionId: json['subscription_id'],
      hasChangeRequest: json['has_change_request'],
      changeRequestApproved: json['change_request_appreved'],
      rating: (json['rating'] as num?)?.toDouble(),
      comment: json['comment'],
      qAnswer: json['q_answar'],
      studentConfirm: json['student_confirm'],
      studentConfirmedAt: json['student_confirmed_at'],
      instructorConfirm: json['instructor_confirm'],
      instructorConfirmedAt: json['instructor_confirmed_at'],
      instructorComment: json['instructor_comment'],
      joinUrl: json['join_url'],
      startUrl: json['start_url'],
      meetingId: json['meeting_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      subscription: json['subscription'] != null ? Subscription.fromJson(json['subscription']) : null,
      createdByUser: json['created_by_user'] != null ? User.fromJson(json['created_by_user']) : null,
      updatedByUser: json['updated_by_user'] != null ? User.fromJson(json['updated_by_user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start': start,
      'end': end,
      'subscription_id': subscriptionId,
      'has_change_request': hasChangeRequest,
      'change_request_appreved': changeRequestApproved,
      'rating': rating,
      'comment': comment,
      'q_answar': qAnswer,
      'student_confirm': studentConfirm,
      'student_confirmed_at': studentConfirmedAt,
      'instructor_confirm': instructorConfirm,
      'instructor_confirmed_at': instructorConfirmedAt,
      'instructor_comment': instructorComment,
      'join_url': joinUrl,
      'start_url': startUrl,
      'meeting_id': meetingId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'subscription': subscription?.toJson(),
      'created_by_user': createdByUser?.toJson(),
      'updated_by_user': updatedByUser?.toJson(),
    };
  }
}

 

import 'package:elbaraa/data/models/material.model.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:elbaraa/data/models/user.dart'; 
class Subscription {
  final int? id;
  final String? startIn;
  final String? endIn;
  final int? status;
  final int? planId;
  final int? materialId;
  final int? instructorId;
  final int? studentId;
  final String? paymentStatus;
  final String? paymentOrderId;
  final String? paymentMethod;
  final String? paymentComment;
  final double? paidAmount;
  final String? country;
  final String? instructorSalaryStatus;
  final int? createdBy;
  final int? updatedBy;

  final MaterialModel? material;
  final User? student;
  final User? instructor;
  final Plan? plan;
  final User? createdByUser;
  final User? updatedByUser;

  Subscription({
    this.id,
    this.startIn,
    this.endIn,
    this.status,
    this.planId,
    this.materialId,
    this.instructorId,
    this.studentId,
    this.paymentStatus,
    this.paymentOrderId,
    this.paymentMethod,
    this.paymentComment,
    this.paidAmount,
    this.country,
    this.instructorSalaryStatus,
    this.createdBy,
    this.updatedBy,
    this.material,
    this.student,
    this.instructor,
    this.plan,
    this.createdByUser,
    this.updatedByUser,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      startIn: json['start_in'],
      endIn: json['end_in'],
      status: json['status'],
      planId: json['plan_id'],
      materialId: json['material_id'],
      instructorId: json['instructor_id'],
      studentId: json['student_id'],
      paymentStatus: json['payment_status'],
      paymentOrderId: json['payment_order_id'],
      paymentMethod: json['payment_method'],
      paymentComment: json['payment_comment'],
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      country: json['country'],
      instructorSalaryStatus: json['instructor_salary_status'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      material: json['material'] != null ? MaterialModel.fromJson(json['material']) : null,
      student: json['student'] != null ? User.fromJson(json['student']) : null,
      instructor: json['instructor'] != null ? User.fromJson(json['instructor']) : null,
      plan: json['plan'] != null ? Plan.fromJson(json['plan']) : null,
      createdByUser: json['created_by_user'] != null ? User.fromJson(json['created_by_user']) : null,
      updatedByUser: json['updated_by_user'] != null ? User.fromJson(json['updated_by_user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_in': startIn,
      'end_in': endIn,
      'status': status,
      'plan_id': planId,
      'material_id': materialId,
      'instructor_id': instructorId,
      'student_id': studentId,
      'payment_status': paymentStatus,
      'payment_order_id': paymentOrderId,
      'payment_method': paymentMethod,
      'payment_comment': paymentComment,
      'paid_amount': paidAmount,
      'country': country,
      'instructor_salary_status': instructorSalaryStatus,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'material': material?.toJson(),
      'student': student?.toJson(),
      'instructor': instructor?.toJson(),
      'plan': plan?.toJson(),
      'created_by_user': createdByUser?.toJson(),
      'updated_by_user': updatedByUser?.toJson(),
    };
  }
}

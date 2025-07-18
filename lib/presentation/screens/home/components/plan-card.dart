import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/models/plan.model.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class PlanCard extends StatelessWidget {
  final Plan plan;
  const PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E8D4B), // Dark green background
          borderRadius: BorderRadius.circular(11.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.end, // Align text to the right for Arabic
          children: [
            Text(
              plan.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10.0),
            Text(
              '${'monthly'.i18n()} / ${plan.currency} ${plan.planCost}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 10.0),
            _buildFeatureRow(plan.sessionPerMonth, 'session_per_month'.i18n()),
            SizedBox(height: 10.0),
            _buildFeatureRowSingle(
              timeOptions[plan.sessionDuration].toString().i18n(),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align to the right
              children: [
                Text(
                  plan.studentCount == 1
                      ? 'student_per_session'
                            .i18n() // If studentCount is 1
                      : plan.studentCount == 2
                      ? 'two_students_per_session'
                            .i18n() // Else if studentCount is 2
                      : 'three_students_per_session'.i18n(),
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 10.0),
                Icon(Icons.check_circle, color: Colors.white, size: 20.0),
              ],
            ),
            SizedBox(height: 30.0),
            Center(
              // Center the button
              child: ElevatedButton(
                onPressed: () {
                   Navigator.of(context).pushNamed(
                              subscripToPlanScreen,
                              arguments: plan.id,
                            );
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SupscripToPlanScreen(planId: plan.id),
                    ),
                  ); */
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD4AF37), // Gold button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.0,
                    vertical: 8.0,
                  ),
                ),
                child: Text(
                  'اشترك',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(int sessionPerMonth, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align to the right
      children: [
        Text(
          sessionPerMonth.toString(),
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 6.0),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 10.0),
        Icon(Icons.check_circle, color: Colors.white, size: 20.0),
      ],
    );
  }

  Widget _buildFeatureRowSingle(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align to the right
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 10.0),
        Icon(Icons.check_circle, color: Colors.white, size: 20.0),
      ],
    );
  }
}

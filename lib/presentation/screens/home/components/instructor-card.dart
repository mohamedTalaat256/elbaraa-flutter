import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/models/instructor.model.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:flutter/material.dart';

class InstructorCard extends StatelessWidget {
  final Instructor instructor;
  const InstructorCard({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: defaultBorderColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(instructor.imageUrl),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    CustomeText(
                      text: instructor.firstName,
                      alignment: TextAlign.start,
                    ),
                    CustomeText(
                      text: instructor.country,
                      alignment: TextAlign.start,
                      fontSize: 13,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 60),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      instructor.education,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(color: Color(0xFF000000)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

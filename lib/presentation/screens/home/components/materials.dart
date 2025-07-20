import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/models/material.model.dart';
import 'package:flutter/material.dart';

class EducationMaterialList extends StatelessWidget {
  final List<MaterialModel> materials;

  const EducationMaterialList({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final material = materials[index];
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: defaultBorderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment
                        .topLeft, // Position the image at the top-left corner
                    child: Container(
                      padding: EdgeInsets.only(top: 8),
                      height: 60,
                      width: 60,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image: '$imagesUrls/${materials[index].image}',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          material.title,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            material.description,
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
          ),
        );
      }, childCount: materials.length),
    );
  }
}

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
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: defaultBorderColor),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      material.title,
                      style: TextStyle(color: Color(0xFF000000)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,

                      child: Text(
                        material.description,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(color: Color(0xFF000000)),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  height: 60,
                  width: 60,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: '$imagesUrls/${materials[index].image}',
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: materials.length),
    );
  }
}

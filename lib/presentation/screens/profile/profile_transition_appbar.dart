// ignore_for_file: unnecessary_null_comparison

import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/presentation/widgets/custome_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;


class ProfileTransitionAppBar extends StatelessWidget {
  final String avatar;
  final String title;
  final double extent;

  ProfileTransitionAppBar(
      {required this.avatar, required this.title, this.extent = 250});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _ProfileTransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _ProfileTransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  io.File? _image;
  final ImagePicker _picker = ImagePicker();

  final _avatarMarginTween = EdgeInsetsTween(
    end: EdgeInsets.only(left: 20.0, top: 50.0),
  );

  final _titleMarginTween = EdgeInsetsTween(
    begin: EdgeInsets.only(bottom: 20),
    end: EdgeInsets.only(left: 94.0, top: 70),
  );

  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.topLeft);

  final String avatar;
  final String title;
  final double extent;

  _ProfileTransitionAppBarDelegate(
      {required this.avatar, required this.title, this.extent = 250})
      : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 72 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final titleMargin = _titleMarginTween.lerp(progress);

    final avatarAlign = _avatarAlignTween.lerp(progress);

    final avatarSize = (1 - progress) * 120 + 60;

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: 120,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
            alignment: avatarAlign,
            child: SizedBox(
              height: progress < 1 ? avatarSize : 60,
              width: progress < 1 ? avatarSize : 60,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage:  _image == null
                        ?NetworkImage(avatar)
                        : FileImage(_image!) as ImageProvider,
                    backgroundColor: Colors.transparent,
                  ),
                  progress < 0.4
                      ? _updateImageButtons(context)
                      : Text(''),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: progress < 0.4 ? 100 * (1 - progress) * 1.5 : 0,
          ),
        ),
        Padding(
          padding:
              progress < 1 ? titleMargin : EdgeInsets.only(left: 94.0, top: 70),
          child: Align(
            alignment: avatarAlign,
            child: progress < 0.9
                ? Text('')
                : Text(
                    title,
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20 + (5 * (1 - progress)),
                        fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    );
  }

  Positioned _updateImageButtons(BuildContext context) {
    return Positioned(
                        bottom: 0,
                        right: -25,
                        child:RawMaterialButton(
                          onPressed: () {
                            _openImagePicker(context);
                          },
                          elevation: 2.0,
                          fillColor: Color(0xFFF5F6F9),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: kTextGreen,
                          ),
                          padding: EdgeInsets.all(8.0),
                          shape: CircleBorder(),
                        )
                       
                        );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(_ProfileTransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        builder: (BuildContext) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
              child: Column(
                children: [
                  CustomeButtonIcon(
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    borderRaduis: 16.0,
                    onPressed: () {
                      getImagefromcamera();
                    },
                    text: 'Gallery',
                    backgroundColor: softTextOrange,
                    //  textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomeButtonIcon(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                    borderRaduis: 16.0,
                    onPressed: () {},
                    text: 'Camera',
                    backgroundColor: softTextOrange,
                    // textColor: Colors.white,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future getImagefromcamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image = io.File(image.path);
     /*  Get.back();

      Get.find<ProfileViewModel>().image_to_upload =  io.File(image.path);
 */

    }
   
  }
}

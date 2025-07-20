import 'dart:io';
import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/profile/profile_bloc.dart';
import 'package:elbaraa/data/business_logic/profile/profile_cubit.dart';
import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/presentation/screens/profile/image_helper.dart';
import 'package:elbaraa/presentation/widgets/custome_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userInfo});
  final User userInfo;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

final imageHelper = ImageHelper();

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Text("data");/*  Scaffold(
        body: CustomScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
          SliverAppBar(
            elevation: 0,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: Container(
                child: CustomeText(
              text: 'Edit Profile',
              fontSize: 23,
            )),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            sliver: MultiSliver(
              children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 64,
                              foregroundImage: FileImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 180,
                              backgroundColor: Color.fromARGB(0, 202, 11, 11),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: baseUrl + widget.userInfo.imageUrl!,
                                  fit: BoxFit.cover,
                                  height: 180,
                                  width: 180,
                                ),
                              ),
                            ),
                      _image != null
                          ? _uploadImageButtons(context, _image!)
                          : _chooseImageButtons(context)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomeText(
                  text: widget.userInfo.firstName!,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: ((value) {
                            widget.userInfo.name = value;
                          }),
                          initialValue: widget.userInfo.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            hintText: 'Enter Name',
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          onChanged: ((value) {
                            widget.userInfo.email = value;
                          }),
                          initialValue: widget.userInfo.email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter Email',
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          onChanged: ((value) {
                            widget.userInfo.about = value;
                          }),
                          initialValue: widget.userInfo.about,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'About',
                            hintText: 'Enter About',
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          onChanged: ((value) {
                            widget.userInfo.phone = value;
                          }),
                          keyboardType: TextInputType.phone,
                          initialValue: widget.userInfo.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                            hintText: 'Enter Phone',
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomeButton(
                            text: 'save',
                            borderRaduis: 12,
                            backgroundColor: kTextGreen,
                            onPressed: () {
                              //  controller.updateMyProfile(userInfo);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ])); */
  }

  bool loading = false;

  Positioned _chooseImageButtons(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 75,
        child: RawMaterialButton(
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
        ));
  }

  Positioned _uploadImageButtons(BuildContext context, File image) {
    return Positioned(
        bottom: 0,
        right: 75,
        child: BlocListener<ProfileBloc, ProfileState>(
            listener: (ctx, state) {
              if (state is ProfileImageUploading) {
                setState(() {
                  loading = true;
                });
              } else if (state is ProfileImageUploadingSuccess) {
                setState(() {
                  loading = false;
                });
              }
            },
            child: RawMaterialButton(
              onPressed: () async {
              /*   BlocProvider.of<ProfileBloc>(context)
                    .add(UploadButtonPressed(image: image)); */
              },
              elevation: 2.0,
              fillColor: Color(0xFFF5F6F9),
              child: Icon(
                loading ? Icons.arrow_circle_up : Icons.upload_rounded,
                color: kTextGreen,
              ),
              padding: EdgeInsets.all(8.0),
              shape: CircleBorder(),
            )));
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        builder: (BuildContext) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 80, right: 80),
              child: Column(
                children: [
                  CustomeButtonIcon(
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    borderRaduis: 8.0,
                    onPressed: () async {
                      final file = await imageHelper.pickImage();

                      if (file != null) {
                        setState(() {
                          _image = File(file.path);
                        });
                      }
                    },
                    text: 'Gallery',
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),

                    //  textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomeButtonIcon(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                    borderRaduis: 8.0,
                    onPressed: () {},
                    text: 'Camera',
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    // textColor: Colors.white,
                  )
                ],
              ),
            ),
          );
        });
  }
}

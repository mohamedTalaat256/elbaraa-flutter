import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/presentation/widgets/custome_button_with_icon.dart';
import 'package:flutter/material.dart';


class ImageButton extends StatefulWidget {
  const ImageButton({Key? key}) : super(key: key);

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {

         _openImagePicker( context) ;
      },
      elevation: 2.0,
      fillColor: Color(0xFFF5F6F9),
      child: Icon(
        Icons.camera_alt_outlined,
        color: kTextGreen,
      ),
      padding: EdgeInsets.all(8.0),
      shape: CircleBorder(),
    );
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
                     icon: Icon(Icons.image, color: Colors.white,),
                    borderRaduis: 16.0,
                    onPressed: () {
                      getImagefromcamera();
                    },
                    text: 'Gallery',
                    backgroundColor: softTextOrange,
                  //  textColor: Colors.white,
                  ),
                  SizedBox(height: 20,),
                  CustomeButtonIcon(
                    icon: Icon(Icons.camera_alt_outlined, color: Colors.white,),
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

    setState(() {
      //Get.back();
    });
  }

  

}

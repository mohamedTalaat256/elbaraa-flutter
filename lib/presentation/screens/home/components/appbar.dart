import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      floating: true,
      pinned: true,
      snap: false,
      centerTitle: false,
      title: Row(
        children: [
        
          CustomeText(
            text:  'اكاديمية البراء',
            color: kTextGreen,
            fontSize: 30,
          ),
        ],
      ),
      bottom: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 40,
          child: Center(child: _searchTextFormFied()),
        ),
        actions: [],
      ),
    );
  }

  Container _searchTextFormFied() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }
}

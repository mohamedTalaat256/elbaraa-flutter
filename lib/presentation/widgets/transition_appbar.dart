// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
class TransitionAppBar extends StatelessWidget {
  final String avatar;
  final String title;
  final double extent;

  TransitionAppBar(
      {required this.avatar, required this.title, this.extent = 250});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {

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

  _TransitionAppBarDelegate(
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
          color:  Theme.of(context).scaffoldBackgroundColor,
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
                    backgroundImage: NetworkImage(avatar),
                    backgroundColor: Colors.transparent,
                  ),
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
                        color: Theme.of(context).primaryColor,
                        fontSize: 20 + (5 * (1 - progress)),
                        fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}

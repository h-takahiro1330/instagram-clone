import 'package:flutter/material.dart';
import 'package:instagram_clone/src/utils/ui_image_data.dart';
import 'package:instagram_clone/src/widgets/story.dart';
import 'package:instagram_clone/src/widgets/friend_suggestion.dart';
import 'package:instagram_clone/src/widgets/post.dart';

class InstaActivities extends StatefulWidget {
  final List<List<String>> listContent = UIImageData.postList;

  InstaActivities() {
    listContent.insert(0, []);
    listContent.insert(2, []);
  }

  @override
  _InstaActivitiesState createState() => _InstaActivitiesState();
}

class _InstaActivitiesState extends State<InstaActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leading(),
        title: title(),
        titleSpacing: 8.0,
        actions: actions(),
      ),
      body: RefreshIndicator(
        child: ListView.builder(
          itemCount: widget.listContent.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Story(); // story.dart from widgets package
            } else if (index == 2) {
              return FriendSuggestion();
            } else {
              return Post(UIImageData.postList[index]);
            }
          }
        ),
        onRefresh: () async {},
      ),
    );
  }

  Widget leading() => IconButton(
    icon: Icon(
      Icons.camera_alt
    ),
    onPressed: () {},
  );

  Widget title() => Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      'Instagram',
      style: TextStyle(
        fontFamily: 'Billabong',
        fontSize: 32.0,
      ),
    )
  );

  List<Widget> actions() => <Widget>[
    Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.live_tv,
            size: 28.0,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        Positioned(
          top: 15.0,
          right: 9.0,
          child: Container(
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle
            ),
          )
        )
      ],
    ),
    Transform.rotate(
      angle: 0.4,
      child: IconButton(
        icon: Icon(
          Icons.send,
          size: 28.0,
        ),
        onPressed: () {},
      ),
    ),
    SizedBox(width: 12.0),
  ];
}
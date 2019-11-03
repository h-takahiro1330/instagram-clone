import 'package:flutter/material.dart';
import 'package:instagram_clone/src/utils/ui_image_data.dart';
import 'package:instagram_clone/src/widgets/circle_image.dart';

class Post extends StatefulWidget {

  final List<String> galleryItems;

  Post(this.galleryItems);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLiked = false;
  int pageViewActiveIndex = 0;
  int likeCount = -1;
  final String caption ='''Styling text in Flutter #something, Styling text in Flutter. #Another, #nepal, Styling text in Flutter. #ktm, #love, #newExperiance Styling text in Flutter. Styling text in Flutter. Styling text in Flutter.''';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        userInfoRow(),
        gallery(),
        SizedBox(height: 8.0),
        actions(),
        SizedBox(height: 10.0),
        likeCounts(),
        SizedBox(height: 8.0),
        galleryCaption(),
        SizedBox(height: 4.0),
        comments(),
        SizedBox(height: 4.0),
        addComment(),
      ],
    );
  }

  Widget userInfoRow() => Row(
    children: <Widget>[
      Container(
        child: CircleImage(
          UIImageData.child,
          imageSize: 36.0,
          whiteMargin: 2.0,
          imageMargin: 6.0,
        )
      ),
      Text('_takahiro_official'),
      Expanded(child: SizedBox()),
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      )
    ],
  );

  Widget gallery() => Container(
    constraints: BoxConstraints(
      maxHeight: 320.0,
      minHeight: 200.0,
      maxWidth: double.infinity,
      minWidth: double.infinity,
    ),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.grey[200],
          width: 1.0
        )
      )
    ),
    child: widget.galleryItems.length > 1
    ? galleryPageView()
    : Image.asset(
        widget.galleryItems[0],
        fit: BoxFit.cover,
    )
  );

  Widget galleryPageView() {
    return PageView.builder(
      itemCount: widget.galleryItems.length,
      onPageChanged: (currentIndex) {
        setState(() {
          this.pageViewActiveIndex = currentIndex;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          widget.galleryItems[index],
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget actions() => Column(
    // alignment: Alignment.center,
    children: <Widget>[
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...widget.galleryItems.map((s) {
              return Container(
                margin: EdgeInsets.only(right: 4.0),
                height: widget.galleryItems.length <= 1 ? 0.0 : 6.0,
                width: widget.galleryItems.length <= 1 ? 0.0 : 6.0,
                decoration: BoxDecoration(
                  color: pageViewActiveIndex == widget.galleryItems.indexOf(s)
                    ? Colors.blueAccent
                    : Colors.grey[300],
                  shape: BoxShape.circle
                ),
              );
            }
          )]
        ),
      ),
      Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.pink : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.comment,
            ),
            onPressed: () {},
          ),
          Transform.rotate(
            angle: 0.4,
            child: IconButton(
              icon: Icon(
                Icons.send,
              ),
              onPressed: () {},
            )
          ),
          Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
            ),
            onPressed: () {},
          ),
        ],
      )
    ],
  );

  Widget likeCounts() => Row(
    children: <Widget>[
      SizedBox(width: 12.0),
      Stack(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          ...UIImageData.storiesList.take(3).map((image) {
            if (likeCount == 2) {
              likeCount = 0;
            } else {
              likeCount ++;
            }
            return Container(
              height: 22.0,
              width: 22.0,
              margin: EdgeInsets.only(right: likeCount * 14.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2.0
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(image)
                )
              ),
            );
          }),
        ],
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Liked by ',
                style: TextStyle(
                  color: Colors.black54
                ),
              ),
              TextSpan(
                text: '_takahiro_official ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextSpan(
                text: 'and ',
                style: TextStyle(
                  color: Colors.black54
                ),
              ),
              TextSpan(
                text: '67,324 others ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ]
          ),
        ),
      )
    ],
  );

  Widget galleryCaption() => Padding(
    padding: const EdgeInsets.only(left: 12.0, right: 16.0),
    child: RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(
          color: Colors.black
        ),
        children: [
          TextSpan(
            text: '_takahiro_official_',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ..._processCaption(
            caption,
            '#',
            TextStyle(color: Colors.blue),
          ),
        ]
      ),
    ),
  );
  List<TextSpan> _processCaption(String caption, String matcher, TextStyle style) {
    List<TextSpan> spans = [];
    caption.split(' ').forEach((text) {
      if (text.toString().contains(matcher)) {
        spans.add(
          TextSpan(
            text: text + ' ',
            style: style
          )
        );
      } else {
        spans.add(
          TextSpan(
            text: text + ' '
          )
        );
      }
    });
    return spans;
  }

  Widget comments() => Container(
    padding: EdgeInsets.only(left: 12.0),
    child: Text(
      'View all 40 comments',
      style: TextStyle(
        color: Colors.black45
      ),
    ),
  );

  Widget addComment() => Row(
    children: <Widget>[
      CircleImage(
        UIImageData.child,
        imageSize: 30.0,
        whiteMargin: 2.0,
        imageMargin: 6.0,
      ),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Add a comment...',
            border: InputBorder.none
          ),
        ),
      ),
      Text(
        '🤗',
        style: TextStyle(
          fontSize: 14.0
        )
      ),
      SizedBox(width: 10.0),
      Text(
        '😘',
        style: TextStyle(
          fontSize: 14.0
        )
      ),
      SizedBox(width: 10.0),
      Padding(
        padding: EdgeInsets.only(top: 4),
        child: Icon(
          Icons.add_circle_outline,
          size: 15.0,
          color: Colors.black26,
        ),
      ),
      SizedBox(width: 12.0),
    ],
  );
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/src/utils/ui_image_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class InstaSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: Icon(Icons.search),
              backgroundColor: Colors.grey[50],
              title: TextField(
                style: TextStyle(
                  fontSize: 18.0
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey[400]
                  )
                ),
              ),
              titleSpacing: 0.0,
              actions: <Widget>[
                Icon(FontAwesomeIcons.qrcode),
                SizedBox(width: 16.0)
              ],
            ),
            GalleryStaggeredGridView()
          ],
        ),
      )
    );
  }
}

class GalleryStaggeredGridView extends StatelessWidget {
  int videoCount = 1;
  int videoIndex = 1;
  List<int> videosIndex = [];
  List<String> images = UIImageData.gallery;

  GalleryStaggeredGridView() {
    videosIndex.add(1);
    for (var i= 0; i <= images.length; i++) {
      if ((i == videoIndex + 8 && videoCount.isOdd) ||
      (i == videoIndex + 10 && videoCount.isEven)) {
        videoCount++;
        videoIndex = i;
        videosIndex.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverStaggeredGrid.countBuilder(
      itemCount: images.length,
      crossAxisCount: 3,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Image.asset(
            UIImageData.gallery[index],
            fit: BoxFit.cover,
            frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              return AnimatedOpacity(
                child: child,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            },
          ),
        );
      },
      staggeredTileBuilder: (int index) {
        return videosIndex.contains(index) ? StaggeredTile.count(2, 2) : StaggeredTile.count(1, 1);
      }
    );
  }
}

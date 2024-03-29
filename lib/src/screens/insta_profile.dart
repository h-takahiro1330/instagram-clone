import 'package:flutter/material.dart';
import 'package:instagram_clone/src/widgets/user_image_with_plus_icon.dart';
import 'package:instagram_clone/src/utils/ui_image_data.dart';

class InstaProfile extends StatefulWidget {
  @override
  _InstaProfileState createState() => _InstaProfileState();
}

class _InstaProfileState extends State<InstaProfile>
  with SingleTickerProviderStateMixin {
    TabController _tabController;
    ScrollController _scrollController;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(vsync: this, length: 2);
      _scrollController = ScrollController();
    }

    @override
    void dispose() {
      _tabController.dispose();
      _scrollController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: appBar(),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(child: userInfo()),
                SliverPersistentHeader(
                  delegate: CustomSliverDelegate(_tabController),
                  pinned: true,
                  floating: true,
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                postGridView(),
                taggedGridView()
              ],
            )
          )
        ),
      );
    }

    Widget appBar() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        title: Row(
          children: <Widget>[
            Text(
              'Hioki_instagram_2019',
              style: TextStyle()
            ),
            SizedBox(width: 4.0),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
            ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.menu),
          SizedBox(width: 16.0),
        ],
      );
    }

    Widget userInfo() {
      Widget stats(String statName, int statCount) {
        return Column(
          children: <Widget>[
            Text(
              statCount.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(statName)
          ],
        );
      }
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border(
            bottom: BorderSide(
              color: Colors.black26,
              width: 0.5
            )
          )
        ),
        child: Container(
          margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  UserImageWithPlusIcon(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        stats('Posts', 20),
                        stats('Followers', 111),
                        stats('Following', 203),
                      ],
                    ),
                  )
                ]
              ),
              SizedBox(height: 16.0),
              Text(
                'Hioki Takahiro',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                )
              ),
              SizedBox(height: 4.0),
              Text(
                'Most good programmers do programming not because they expect to get paid or get adulation by the public, but because it is fun to program.',
                style: TextStyle(),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black26,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(0.5),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      );
    }

    Widget postGridView() {
      return GridView.builder(
        itemCount: 50,
        padding: EdgeInsets.only(top: 8.0),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  UIImageData.man2
                )
              )
            ),
          );
        },
      );
    }

    Widget taggedGridView() {
      return GridView.builder(
        itemCount: 4,
        padding: EdgeInsets.only(top: 4.0),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  UIImageData.man4,
                ),
              ),
            ),
          );
        }
      );
    }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  TabController _tabController;
  CustomSliverDelegate(this._tabController);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.black,
        tabs: <Widget>[
          Icon(Icons.grid_on),
          Icon(Icons.contacts),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
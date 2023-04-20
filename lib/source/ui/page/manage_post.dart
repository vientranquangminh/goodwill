import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/page/manage_post/showing_tabbar_view.dart';

class ManagePost extends StatefulWidget {
  const ManagePost({super.key});

  @override
  State<ManagePost> createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late String _userName;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    _userName = "Thành";
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          UserProfileWidget(
            userName: _userName,
          ),
          AppBar(
            automaticallyImplyLeading: false,
            title: TabBar(
              controller: _tabController,
              tabs: tabs,
              indicatorColor: Colors.white,
              indicatorWeight: 5.0,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
              OutlinedButton(
                  onPressed: () {},
                  child: Text('Connect to your payment wallet'))
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> tabs = const <Widget>[
  Tab(
    // icon: Icon(Icons.cloud_outlined),
    text: "Showing (0)",
  ),
  Tab(
    text: "Overdate (0)",
  ),
  Tab(
    text: "Denied (0)",
  ),
];

List<Widget> tabViews = <Widget>[
  ShowingTabbarView(),
  ListView(
    children: [
      Text('No posts in this category'),
    ],
  ),
  ListView(
    children: [
      Text('No posts in this category'),
    ],
  ),
];

import 'package:flutter/material.dart';

import 'managed_post_listitem.dart';

class ShowingTabbarView extends StatefulWidget {
  const ShowingTabbarView({super.key});

  @override
  State<ShowingTabbarView> createState() => _ShowingTabbarViewState();
}

class _ShowingTabbarViewState extends State<ShowingTabbarView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: managedPostListItems,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

List<Widget> managedPostListItems = [
  const ManagedPostListItem(),
  const ManagedPostListItem(),
  const ManagedPostListItem(),
  const ManagedPostListItem(),
  const ManagedPostListItem(),
  const ManagedPostListItem(),
  const ManagedPostListItem(),
  const ManagedPostListItem(),
  const ManagedPostListItem(),
];

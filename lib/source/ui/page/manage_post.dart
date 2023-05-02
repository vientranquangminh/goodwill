import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/manage_post/showing_tabbar_view.dart';
import 'package:provider/provider.dart';

class ManagePost extends StatefulWidget {
  const ManagePost({super.key});

  @override
  State<ManagePost> createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> with TickerProviderStateMixin {
  late TabController _tabController;
  late String _userName;
  final Future<List<ProductModel>?> _future =
      ProductService.getAllProductsFrom(AuthService.userId!);

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProfile?>();
    String _userName =
        user?.getDisplayName() ?? AuthService.user?.email ?? 'Anonymous user';

    return FutureProvider<List<ProductModel>?>.value(
        initialData: [],
        value: _future,
        builder: (context, snapshot) {
          final products =
              Provider.of<List<ProductModel>?>(context, listen: true);
          final List<ProductModel> showingProducts = [];
          final List<ProductModel> overdateProducts = [];
          final List<ProductModel> deniedProducts = [];

          products?.forEach((product) {
            switch (product.status) {
              case OwnProductStatus.SHOWING:
                {
                  showingProducts.add(product);
                  break;
                }
              case OwnProductStatus.OVERDATE:
                {
                  overdateProducts.add(product);
                  break;
                }
              case OwnProductStatus.DENIED:
                {
                  deniedProducts.add(product);
                  break;
                }
              default:
                showingProducts.add(product);
                break;
            }
          });

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
                    tabs: [
                      Tab(
                        // icon: Icon(Icons.cloud_outlined),
                        text: "Showing (${showingProducts.length})",
                      ),
                      Tab(
                        text: "Overdate (${overdateProducts.length})",
                      ),
                      Tab(
                        text: "Denied (${deniedProducts.length})",
                      ),
                    ],
                    indicatorColor: Colors.white,
                    indicatorWeight: 5.0,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ShowingTabbarView(
                        products: showingProducts,
                      ),
                      ShowingTabbarView(
                        products: overdateProducts,
                      ),
                      ShowingTabbarView(
                        products: deniedProducts,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
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

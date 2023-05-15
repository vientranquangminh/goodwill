import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/circle_avatar/circle_avatar.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/manage_post/showing_tabbar_view.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:provider/provider.dart';

class ManagePost extends StatefulWidget {
  const ManagePost({super.key});

  @override
  State<ManagePost> createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> with TickerProviderStateMixin {
  late TabController _tabController;
  late String _userName;
  // final Future<List<ProductModel>?> _future =
  //     ProductService.getAllProductsFrom(AuthService.userId!);
  final Stream<List<ProductModel>?> _stream =
      ProductService.getStreamAllProductsFrom(AuthService.userId!);

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

    return StreamProvider<List<ProductModel>?>.value(
        initialData: [],
        value: _stream,
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
    String userProfile = context.watch<UserProfile?>()?.profilePicture ??
        Constant.SAMPLE_AVATAR_URL;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Avatar(
                    imagePath: userProfile,
                    size: const Size(50, 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32.0),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  context.pushNamed(Routes.connectWallet);
                },
                child: const Text(
                  'Connect wallet',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

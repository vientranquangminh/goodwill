import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
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
  final Stream<List<ProductModel>?> _stream =
      ProductService.getStreamAllProductsFrom(AuthService.userId!);

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProfile?>();
    String userName =
        user?.getDisplayName() ?? AuthService.user?.email ?? 'Anonymous user';

    return StreamProvider<List<ProductModel>?>.value(
        initialData: const [],
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
                  userName: userName,
                ),
                AppBar(
                  automaticallyImplyLeading: false,
                  title: TabBar(
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.white,
                    controller: _tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    tabs: [
                      Tab(
                        text:
                            "${context.localizations.showing} (${showingProducts.length})",
                      ),
                      Tab(
                        text:
                            "${context.localizations.overdate} (${overdateProducts.length})",
                      ),
                      Tab(
                        text:
                            "${context.localizations.denied} (${deniedProducts.length})",
                      ),
                    ],
                    indicatorColor: Colors
                        .transparent, // Set the indicatorColor to transparent
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 32.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
          OutlinedButton(
              onPressed: () {
                context.pushNamed(Routes.connectWallet);
              },
              child: Row(
                children: [
                  Text(
                    context.localizations.wallet,
                    style: context.blackS12W500,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Assets.images.addImage.image(width: 20.w, height: 20.w)
                ],
              )),
        ],
      ),
    );
  }
}

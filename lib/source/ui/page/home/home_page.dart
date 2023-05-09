// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/circle_avatar/circle_avatar.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/models/categories_model.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/admin/login_screen.dart';
import 'package:goodwill/source/ui/page/home/components/banner.dart';
import 'package:goodwill/source/ui/page/home/components/category_card.dart';
import 'package:goodwill/source/ui/page/home/components/post_card.dart';
import 'package:provider/provider.dart';

import 'components/title_of_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _userName;
  late String _userProfilePicture;
  final Future<List<ProductModel>?> _future = ProductService.getAllProducts();

  String _getUserName(BuildContext context) {
    final user = context.watch<UserProfile?>();
    if (user == null) {
      return AuthService.user?.email ?? 'Anonymous user';
    }
    return user.nickName ?? user.fullName ?? 'Guest ${user.id.hashCode}';
  }

  String _getAvatar(BuildContext context) {
    final user = context.watch<UserProfile?>();
    return user?.profilePicture ?? "";
  }

  @override
  Widget build(BuildContext context) {
    _userName = _getUserName(context);
    _userProfilePicture = _getAvatar(context);

    return FutureProvider<List<ProductModel>?>.value(
        initialData: [],
        value: _future,
        builder: (context, snapshot) {
          final products =
              Provider.of<List<ProductModel>?>(context, listen: true);
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Avatar(
                                imagePath: _userProfilePicture,
                                size: const Size(50, 50),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.greeting(),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _userName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginAdminScreen(),
                                      ));
                                },
                                icon: Assets.svgs.notification.svg()),
                            IconButton(
                                onPressed: () {
                                  context.pushNamed(Routes.chatScreen);
                                },
                                icon: Assets.svgs.message.svg()),
                          ],
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 3,
                                      offset: Offset(0.5, 2))
                                ]),
                            child: TextField(
                              autofocus: false,
                              onTap: () =>
                                  context.pushNamed(Routes.searchScreen),
                              cursorColor: ColorName.black,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                filled: true,
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.black),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                fillColor: Colors.grey.shade100,
                                hintText: context.localizations.search,
                                hintStyle: const TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Assets.svgs.filter
                                      .svg(color: Colors.black),
                                  onPressed: () {},
                                ),
                              ),
                            ))),
                    const BannerAds(),
                    TitleOfList(title: context.localizations.exploreCategories),
                    _buildSearchProducts(
                      defaultAllProducts: products ?? [],
                    ),
                    TitleOfList(title: context.localizations.postForYou),
                    _buildForYouProducts(
                      forYouProducts: products ?? [],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _buildSearchProducts extends StatelessWidget {
  const _buildSearchProducts({
    super.key,
    required this.defaultAllProducts,
  });

  final List<ProductModel> defaultAllProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 15.0,
          children: List.generate(listCategories.length, (index) {
            // List listPost = defaultAllProducts
            //     .where((element) =>
            //         element.category == listCategories[index].title)
            //     .toList();
            return GestureDetector(
                onTap: () => context.pushNamedWithParam(
                    Routes.category, listCategories[index].title),
                child: CategoriesCard(categories: listCategories[index]));
          })),
    );
  }
}

class _buildForYouProducts extends StatelessWidget {
  const _buildForYouProducts({
    super.key,
    required this.forYouProducts,
  });

  final List<ProductModel> forYouProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.54,
      crossAxisSpacing: 20,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(forYouProducts.length, (index) {
        return GestureDetector(
          onTap: () => context.pushNamedWithParam(
              Routes.productDetails, forYouProducts[index]),
          child: PostCard(postCard: forYouProducts[index]),
        );
      }),
    );
  }
}

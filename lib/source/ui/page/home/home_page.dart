import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/circle_avatar/circle_avatar.dart';
import 'package:goodwill/source/data/model/post_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/models/categories_model.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/ui/page/home/components/banner.dart';
import 'package:goodwill/source/ui/page/home/components/category_card.dart';
import 'package:goodwill/source/ui/page/home/components/post_card.dart';

import 'components/title_of_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _userName;
  late String _userProfilePicture;
  late List<PostModel> _posts;

  @override
  void initState() {
    // TODO: implement initState

    // _userAvatarImagePath = Assets.images.homePage.person.path;
    super.initState();
  }

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
    _posts = PostModel.listPostModel;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Avatar(
                        imagePath: _userProfilePicture,
                        size: const Size(50, 50),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.category);
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
                        onTap: () => context.pushNamed(Routes.searchScreen),
                        cursorColor: ColorName.black,
                        maxLines: 1,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          fillColor: Colors.grey.shade100,
                          hintText: context.localizations.search,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Assets.svgs.filter.svg(color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                      ))),
              const BannerAds(),
              TitleOfList(title: context.localizations.exploreCategories),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 15.0,
                    children: List.generate(listCategories.length, (index) {
                      return CategoriesCard(categories: listCategories[index]);
                    })),
              ),
              TitleOfList(title: context.localizations.postForYou),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.70,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(_posts.length, (index) {
                  return GestureDetector(
                      onTap: () => context.pushNamedWithParam(
                          Routes.productDetails, _posts[index]),
                      child: PostCard(postCard: _posts[index]));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/models/categories_model.dart';
import 'package:goodwill/source/models/post_model.dart';
import 'package:goodwill/source/routes.dart';
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
  @override
  Widget build(BuildContext context) {
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
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage(Assets.images.homePage.person.path),
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
                            const Text("Turtle", // dummy text
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ))
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
                height: 200,
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
                children: List.generate(listPostModel.length, (index) {
                  return GestureDetector(
                      onTap: () => context.pushNamedWithParam(
                          Routes.productDetails, listPostModel[index]),
                      child: PostCard(postCard: listPostModel[index]));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

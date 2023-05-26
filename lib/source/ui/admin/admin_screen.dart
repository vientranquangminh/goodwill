import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/ui/admin/add_article.dart';
import 'package:goodwill/source/ui/admin/add_product.dart';
import 'package:goodwill/source/ui/admin/dashboard.dart';
import 'package:goodwill/source/ui/admin/user_screen.dart';
import 'package:goodwill/source/ui/admin/topic_screen.dart';

import 'product_page.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selected = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    List<Menu> menuList = [
      Menu(item: "Dasboard", icon: 'assets/svgs/dashboard.svg'),
      Menu(item: "User", icon: 'assets/svgs/user_admin.svg'),
      Menu(item: "Product", icon: 'assets/svgs/product.svg'),
      Menu(item: "Article", icon: 'assets/svgs/trending-topic.svg'),
      Menu(item: "Add Product", icon: 'assets/svgs/trending-topic.svg'),
      Menu(item: "Add Article", icon: 'assets/svgs/trending-topic.svg'),
    ];
    return Scaffold(
      body: Row(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            width: 200,
            child: Column(
              children: [
                Assets.svgs.mainIcon.svg(color: Colors.white),
                Text(
                  context.localizations.goodwill,
                  style: const TextStyle(color: Colors.white, fontSize: 17)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _pageController.jumpToPage(index);
                              selected = index;
                            });
                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(microseconds: 500),
                                width: 5,
                                height: (selected == index) ? 65 : 0,
                                color: Colors.white,
                              ),
                              Expanded(
                                  child: Container(
                                color: (selected == index)
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        menuList[index].icon,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        menuList[index].item,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: menuList.length),
                ),
              ],
            ),
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            children: const [
              DashBoardScreen(),
              UserPage(),
              ProductPage(),
              TopicScreen(),
              AddProductScreen(),
              AddArticle()
            ],
          ))
        ],
      ),
    );
  }
}

class TitleAdminScreen extends StatelessWidget {
  const TitleAdminScreen({
    Key? key,
    required this.title,
    required this.width,
  }) : super(key: key);
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Menu {
  String icon;
  String item;
  Menu({required this.item, required this.icon});
}

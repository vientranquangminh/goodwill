import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodwill/source/data/model/post_model.dart';
import 'package:goodwill/source/ui/page/search/widgets/my_list_product.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';

import '../../../../gen/assets.gen.dart';
import 'widgets/title_tabbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<PostModel> posts = PostModel.listPostModel;
  List<PostModel> clothes = PostModel.listPostModel
      .where((element) => element.category == 'Clothes')
      .toList();
  List<PostModel> shoes = PostModel.listPostModel
      .where((element) => element.category == 'Shoes')
      .toList();
  List<PostModel> bags = PostModel.listPostModel
      .where((element) => element.category == 'Bags')
      .toList();
  List<PostModel> electronic = PostModel.listPostModel
      .where((element) => element.category == 'Electronics')
      .toList();
  List<PostModel> watch = PostModel.listPostModel
      .where((element) => element.category == 'Watch')
      .toList();
  List<PostModel> jewelry = PostModel.listPostModel
      .where((element) => element.category == 'Jewelry')
      .toList();
  List<PostModel> kitchen = PostModel.listPostModel
      .where((element) => element.category == 'Kitchen')
      .toList();
  List<PostModel> toys = PostModel.listPostModel
      .where((element) => element.category == 'Toys')
      .toList();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 9, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Item",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    fillColor: Colors.grey[200],
                    hintText: 'Search',
                    hintStyle: const TextStyle(fontSize: 16.0),
                    suffixIcon: IconButton(
                        icon: Assets.svgs.filter.svg(color: Colors.black),
                        onPressed: () {}),
                  ),
                  onChanged: searchProduct),
            ),
            SizedBox(
              height: 30,
              child: TabBar(
                controller: tabController,
                labelColor: Colors.white,
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black),
                tabs: const [
                  TabbarTitle(title: 'All'),
                  TabbarTitle(title: 'Clothes'),
                  TabbarTitle(title: 'Shoes'),
                  TabbarTitle(title: 'Bags'),
                  TabbarTitle(title: 'Electronic'),
                  TabbarTitle(title: 'Watch'),
                  TabbarTitle(title: 'Jewelry'),
                  TabbarTitle(title: 'Kitchen'),
                  TabbarTitle(title: 'Toys'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  posts.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(
                          posts: posts,
                        ),
                  clothes.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: clothes),
                  shoes.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: shoes),
                  bags.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: bags),
                  electronic.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: electronic),
                  watch.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: watch),
                  jewelry.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: jewelry),
                  kitchen.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: kitchen),
                  toys.isEmpty
                      ? const NotFoundScreen()
                      : MyListProduct(posts: toys)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchProduct(String query) {
    final all = compareProductName(query, PostModel.listPostModel).toList();
    final clothesSearch = compareProductName(query, clothes).toList();
    final shoesSearch = compareProductName(query, shoes).toList();
    final bagsSearch = compareProductName(query, bags).toList();
    final electronicSearch = compareProductName(query, electronic).toList();
    final watchSearch = compareProductName(query, watch).toList();
    final jewelrySearch = compareProductName(query, jewelry).toList();
    final kitchenSearch = compareProductName(query, kitchen).toList();
    final toysSearch = compareProductName(query, toys).toList();

    setState(() {
      if (query.isNotEmpty) {
        posts = all;
        clothes = clothesSearch;
        shoes = shoesSearch;
        bags = bagsSearch;
        electronic = electronicSearch;
        watch = watchSearch;
        jewelry = jewelrySearch;
        kitchen = kitchenSearch;
        toys = toysSearch;
      } else {
        posts = PostModel.listPostModel;
        clothes = PostModel.listPostModel
            .where((element) => element.category == 'Clothes')
            .toList();

        shoes = PostModel.listPostModel
            .where((element) => element.category == 'Shoes')
            .toList();

        bags = PostModel.listPostModel
            .where((element) => element.category == 'Bags')
            .toList();
        electronic = PostModel.listPostModel
            .where((element) => element.category == 'Electronic')
            .toList();
        jewelry = PostModel.listPostModel
            .where((element) => element.category == 'Jewelry')
            .toList();
        watch = PostModel.listPostModel
            .where((element) => element.category == 'Watch')
            .toList();
        kitchen = PostModel.listPostModel
            .where((element) => element.category == 'Kitchen')
            .toList();
        toys = PostModel.listPostModel
            .where((element) => element.category == 'Toys')
            .toList();
      }
    });
  }

  // ignore: non_constant_identifier_names
  Iterable<PostModel> compareProductName(String query, List<PostModel> list) {
    return list.where((doctor) {
      final doctorName = doctor.title!.toLowerCase();

      final searchLower = query.toLowerCase();

      return doctorName.contains(searchLower);
    });
  }
}

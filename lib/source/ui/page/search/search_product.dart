import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodwill/source/ui/page/search/widgets/my_list_product.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';

import '../../../models/post_model.dart';
import '../product/widgets/product_card.dart';
import 'widgets/title_tabbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<PostModel> posts = listPostModel;
  List<PostModel> clothes =
      listPostModel.where((element) => element.category == 'Clothes').toList();
  List<PostModel> shoes =
      listPostModel.where((element) => element.category == 'Shoes').toList();
  List<PostModel> bags =
      listPostModel.where((element) => element.category == 'Bags').toList();
  List<PostModel> electronic = listPostModel
      .where((element) => element.category == 'Electronics')
      .toList();
  List<PostModel> watch =
      listPostModel.where((element) => element.category == 'Watch').toList();
  List<PostModel> jewelry =
      listPostModel.where((element) => element.category == 'Jewelry').toList();
  List<PostModel> kitchen =
      listPostModel.where((element) => element.category == 'Kitchen').toList();
  List<PostModel> toys =
      listPostModel.where((element) => element.category == 'Toys').toList();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 9, vsync: this);
    return Scaffold(
      appBar: AppBar(
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
                        icon: SvgPicture.asset(
                          'assets/images/home_page/filter.svg',
                          color: Colors.black,
                        ),
                        onPressed: () {}),
                  ),
                  onChanged: searchDoctor),
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

  // void searchDoctor(String query, List<PostModel> doctorList) {
  //   final suggestions = doctorList.where((doctor) {
  //     final doctorName = doctor.doctorName.toLowerCase();

  //     final searchLower = query.toLowerCase();

  //     return doctorName.contains(searchLower);
  //   }).toList();

  //   setState(() {
  //     if (query.isNotEmpty) {
  //       posts = suggestions;
  //     } else {
  //       posts = doctorList;
  //     }
  //   });
  // }
  void searchDoctor(String query) {
    final all = compareDoctorName(query, listPostModel).toList();
    final clothesSearch = compareDoctorName(query, clothes).toList();
    final shoesSearch = compareDoctorName(query, shoes).toList();
    final bagsSearch = compareDoctorName(query, bags).toList();
    final electronicSearch = compareDoctorName(query, electronic).toList();
    final watchSearch = compareDoctorName(query, watch).toList();
    final jewelrySearch = compareDoctorName(query, jewelry).toList();
    final kitchenSearch = compareDoctorName(query, kitchen).toList();
    final toysSearch = compareDoctorName(query, toys).toList();

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
        posts = listPostModel;
        clothes = listPostModel
            .where((element) => element.category == 'Clothes')
            .toList();

        shoes = listPostModel
            .where((element) => element.category == 'Shoes')
            .toList();

        bags = listPostModel
            .where((element) => element.category == 'Bags')
            .toList();
        electronic = listPostModel
            .where((element) => element.category == 'Electronic')
            .toList();
        jewelry = listPostModel
            .where((element) => element.category == 'Jewelry')
            .toList();
        watch = listPostModel
            .where((element) => element.category == 'Watch')
            .toList();
        kitchen = listPostModel
            .where((element) => element.category == 'Kitchen')
            .toList();
        toys = listPostModel
            .where((element) => element.category == 'Toys')
            .toList();
      }
    });
  }

  // ignore: non_constant_identifier_names
  Iterable<PostModel> compareDoctorName(String query, List<PostModel> list) {
    return list.where((doctor) {
      final doctorName = doctor.name.toLowerCase();

      final searchLower = query.toLowerCase();

      return doctorName.contains(searchLower);
    });
  }
}

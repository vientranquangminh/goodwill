import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/enum/category_enum.dart';
import 'package:goodwill/source/ui/page/search/widgets/my_list_product.dart';

import '../../../../gen/assets.gen.dart';
import 'widgets/title_tabbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  List<ProductModel> posts = ProductModel.sampleProductModels;
  List<ProductModel> clothes = ProductModel.sampleProductModels
      .where((element) => element.category == 'clothes')
      .toList();
  List<ProductModel> shoes = ProductModel.sampleProductModels
      .where((element) => element.category == 'shoes')
      .toList();
  List<ProductModel> bags = ProductModel.sampleProductModels
      .where((element) => element.category == 'bags')
      .toList();
  List<ProductModel> electronic = ProductModel.sampleProductModels
      .where((element) => element.category == 'electronics')
      .toList();
  List<ProductModel> watch = ProductModel.sampleProductModels
      .where((element) => element.category == 'watchs')
      .toList();
  List<ProductModel> jewelry = ProductModel.sampleProductModels
      .where((element) => element.category == 'jewelry')
      .toList();
  List<ProductModel> kitchen = ProductModel.sampleProductModels
      .where((element) => element.category == 'kitchens')
      .toList();
  List<ProductModel> toys = ProductModel.sampleProductModels
      .where((element) => element.category == 'toys')
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
                  MyListProduct(
                    category: null, // all
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.CLOTHES.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.SHOES.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.BAGS.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.ELECTRONIC.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.WATCH.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.JEWELRY.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.KITCHEN.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                  MyListProduct(
                    category: CategoryEnum.TOYS.toLowerCase(),
                    searchText: _searchController.text,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchProduct(String query) {
    debugPrint('Query ${query}');
    debugPrint(_searchController.text);

    final all =
        compareProductName(query, ProductModel.sampleProductModels).toList();
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
        posts = ProductModel.sampleProductModels;
        clothes = ProductModel.sampleProductModels
            .where((element) => element.category == 'Clothes')
            .toList();

        shoes = ProductModel.sampleProductModels
            .where((element) => element.category == 'Shoes')
            .toList();

        bags = ProductModel.sampleProductModels
            .where((element) => element.category == 'Bags')
            .toList();
        electronic = ProductModel.sampleProductModels
            .where((element) => element.category == 'Electronic')
            .toList();
        jewelry = ProductModel.sampleProductModels
            .where((element) => element.category == 'Jewelry')
            .toList();
        watch = ProductModel.sampleProductModels
            .where((element) => element.category == 'Watch')
            .toList();
        kitchen = ProductModel.sampleProductModels
            .where((element) => element.category == 'Kitchen')
            .toList();
        toys = ProductModel.sampleProductModels
            .where((element) => element.category == 'Toys')
            .toList();
      }
    });
  }

  // ignore: non_constant_identifier_names
  Iterable<ProductModel> compareProductName(
      String query, List<ProductModel> list) {
    return list.where((doctor) {
      final doctorName = doctor.title!.toLowerCase();

      final searchLower = query.toLowerCase();

      return doctorName.contains(searchLower);
    });
  }
}

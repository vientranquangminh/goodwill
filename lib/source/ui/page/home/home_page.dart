import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goodwill/source/models/post_model.dart';
import 'package:goodwill/source/ui/page/home/components/banner.dart';
import 'package:goodwill/source/ui/page/home/components/categories_card.dart';
import 'package:goodwill/source/ui/page/home/components/post_card.dart';
import 'package:goodwill/source/ui/page/home/get_greeting.dart';

import '../../../models/categories_model.dart';
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
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage("assets/images/home_page/person.jpg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              GetGreeting.greeting(),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            // StreamBuilder<DocumentSnapshot>(
                            //   stream: patient,
                            //   builder: ((context, snapshot) {
                            //     if (snapshot.hasError) {
                            //       return const Text('Something went wrong');
                            //     }
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return const Text("Loading...",
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 20));
                            //     }
                            //     return Text(snapshot.data!.get('nickname'),
                            //         style: const TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 20,
                            //         ));
                            //   }),
                            // )
                            const Text("Turtle",
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
                          onPressed: () {},
                          icon:
                              SvgPicture.asset('assets/svgs/notification.svg')),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/svgs/message.svg'))
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
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                          suffixIcon: IconButton(
                              icon: SvgPicture.asset(
                                'assets/svgs/filter.svg',
                                color: Colors.black,
                              ),
                              onPressed: () {}),
                        ),
                      ))),
              const BannerAds(),
              const TitleOfList(title: "Explore categories"),
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
              const TitleOfList(title: "Post for you"),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.70,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(listPostModel.length, (index) {
                  return PostCard(postCard: listPostModel[index]);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/common/widgets/circle_avatar/circle_avatar.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button_with_icon.dart';
import 'package:goodwill/source/common/widgets/indicator/dot_indiccator.dart';
import 'package:goodwill/source/data/model/cart_item_model.dart';
import 'package:goodwill/source/data/dto/chatroom_dto.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/cart_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/message_helper.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final arguments = context.getParam() as ProductModel;
    log(arguments.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localizations.productDetails.toUpperCase(),
          style: context.blackS16W700,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: PlatformIconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorName.black,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          PlatformIconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: ColorName.black,
              size: 30,
            ),
            onPressed: () {
              context.pushNamed(Routes.cartProduct);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: SizedBox(
                          height: 300.h,
                          child: PageView.builder(
                            onPageChanged: (int index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemCount: arguments.images!.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: double.infinity,
                                height: 400.h,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitHeight,
                                  imageUrl: arguments.images![index],
                                  errorWidget: (context, url, error) {
                                    return Text(context
                                        .localizations.somethingWentWrong);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      DotIndicator(
                        currentIndex: _currentIndex,
                        itemCount: arguments.images!.length,
                        dotColor: Colors.black,
                        dotSize: 8.0,
                        spacing: 8.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  arguments.title.toString(),
                                  style: context.blackS20W700,
                                ),
                              ],
                            ),
                            const Divider(
                              color: ColorName.black,
                            ),
                            Text(
                              context.localizations.description,
                              style: context.blackS16W700,
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(arguments.description.toString()),
                            SizedBox(
                              height: 12.h,
                            ),
                            RichText(
                              text: TextSpan(
                                text: context.localizations.category,
                                style: context.blackS16W700,
                                children: [
                                  TextSpan(
                                    text: arguments.category,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            RichText(
                              text: TextSpan(
                                text: context.localizations.address,
                                style: context.blackS16W700,
                                children: [
                                  TextSpan(
                                    text: arguments.location,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            FutureBuilder<UserProfile?>(
                                future: UserProfileService.getUserProfile(
                                    arguments.ownerId ?? ""),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    UserProfile? userProfile = snapshot.data;
                                    String phoneNumber =
                                        userProfile!.phoneNumber.toString();
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Avatar(
                                              imagePath:
                                                  userProfile.profilePicture,
                                              size: const Size(50, 50),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  userProfile.fullName ?? '',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            PlatformIconButton(
                                                padding: EdgeInsets.zero,
                                                icon: Assets.svgs.message.svg(
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            ColorName.black,
                                                            BlendMode.srcIn)),
                                                onPressed: () async {
                                                  UserProfile? userProfile =
                                                      await UserProfileService
                                                          .getUserProfile(
                                                              arguments
                                                                  .ownerId!);
                                                  List<String> ids = [
                                                    arguments.ownerId!,
                                                    AuthService.userId!
                                                  ];

                                                  final chatRoomDto = ChatRoomDto(
                                                      chatRoomId: MessageHelper
                                                          .getChatRoomId(ids),
                                                      sender: userProfile
                                                              ?.getDisplayName() ??
                                                          'User',
                                                      targetUserId:
                                                          arguments.ownerId!);
                                                  if (context.mounted) {
                                                    context.pushNamedWithParam(
                                                        Routes.roomChatScreen,
                                                        chatRoomDto);
                                                  }
                                                }),
                                            PlatformIconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.message_outlined,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  Uri uri = Uri.parse(
                                                      'sms://$phoneNumber');
                                                  _launch(uri);
                                                }),
                                            PlatformIconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  CupertinoIcons.phone_circle,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  Uri uri = Uri.parse(
                                                      'tel://$phoneNumber');
                                                  _launch(uri);
                                                }),
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                  return Container();
                                }),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  context.localizations.quantity,
                                  style: context.blackS16W500,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                _selectQuantityWidget(quantity, context, () {
                                  if (quantity < 2) {
                                    quantity = 2;
                                  }
                                  setState(() {
                                    quantity--;
                                  });
                                }, () {
                                  setState(() {
                                    quantity++;
                                  });
                                })
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(context.localizations.totalPrice,
                          style: context.blackS10W400),
                      Text(
                        "${NumberFormat('#,##0').format(arguments.price)} ${Constant.VN_CURRENCY}",
                        style: context.blackS20W700,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: PrimaryButtonWithIcon(
                          svg: Assets.svgs.bag.svg(
                              height: 12.h,
                              colorFilter: const ColorFilter.mode(
                                  ColorName.white, BlendMode.srcIn)),
                          buttonColor: ColorName.black,
                          textColor: ColorName.white,
                          fontSize: 12,
                          radius: 20.0,
                          text: context.localizations.addToCart,
                          customFunction: () {
                            // Add to cart

                            CartItemModel cartItemModel = CartItemModel(
                              productId: arguments.id,
                              quantity: quantity,
                              createdAt: DateTime.now(),
                            );
                            CartService.addCartItem(cartItemModel);
                          }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _launch(Uri uri) async {
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}

Widget _selectQuantityWidget(int text, BuildContext context,
    VoidCallback subtractFunc, VoidCallback addFunc) {
  return Container(
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 236),
        borderRadius: BorderRadius.all(Radius.circular(30.r))),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlatformIconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.remove,
            color: ColorName.black,
          ),
          onPressed: subtractFunc,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          text.toString(),
          style: context.blackS16W500,
        ),
        SizedBox(
          width: 5.w,
        ),
        PlatformIconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add, color: ColorName.black),
          onPressed: addFunc,
        )
      ],
    ),
  );
}

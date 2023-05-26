import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/resources/dimens.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/home/components/post_card.dart';
import 'package:provider/provider.dart';

class ExternalProfile extends StatelessWidget {
  const ExternalProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfile = context.getParam() as UserProfile;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorName.black,
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: ColorName.white,
        elevation: 0.0,
        title: Text(
          userProfile.fullName.toString(),
          style: const TextStyle(color: ColorName.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(userProfile.profilePicture ??
                  'https://t4.ftcdn.net/jpg/03/59/58/91/360_F_359589186_JDLl8dIWoBNf1iqEkHxhUeeOulx0wOC5.jpg'),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      context.localizations.fullName,
                      style: context.blackS12W500
                          ?.copyWith(fontSize: Dimens.fontSize14),
                    ),
                  ),
                  Text(
                    userProfile.fullName ?? '',
                    style: context.blackS16W500,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Divider(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      context.localizations.nickname,
                      style: context.blackS12W500
                          ?.copyWith(fontSize: Dimens.fontSize14),
                    ),
                  ),
                  Text(
                    userProfile.nickName ?? '',
                    style: context.blackS16W500,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Divider(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      context.localizations.dateOfBirth,
                      style: context.blackS12W500
                          ?.copyWith(fontSize: Dimens.fontSize14),
                    ),
                  ),
                  Text(
                    userProfile.dateOfBirth.toString(),
                    style: context.blackS16W500,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Divider(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      context.localizations.gender,
                      style: context.blackS12W500
                          ?.copyWith(fontSize: Dimens.fontSize14),
                    ),
                  ),
                  Text(
                    userProfile.gender.toString(),
                    style: context.blackS16W500,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Divider(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      context.localizations.phoneNumber,
                      style: context.blackS12W500
                          ?.copyWith(fontSize: Dimens.fontSize14),
                    ),
                  ),
                  Text(
                    userProfile.phoneNumber.toString(),
                    style: context.blackS16W500,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Divider(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      context.localizations.address,
                      style: context.blackS12W500
                          ?.copyWith(fontSize: Dimens.fontSize14),
                    ),
                  ),
                  Text(
                    userProfile.address.toString(),
                    style: context.blackS16W500,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Divider(
                  color: ColorName.black,
                ),
              ),
              StreamProvider<List<ProductModel>?>(
                create: (_) =>
                    ProductService.getStreamAllProductsFrom(userProfile.id),
                initialData: const [], // Provide initial data if needed
                child: Consumer<List<ProductModel>>(
                  builder: (context, products, child) {
                    return ExternalProfileProducts(
                      externalProfileProducts: products,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAvatar(String path) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(100.r)),
    child: CachedNetworkImage(
      fit: BoxFit.fitWidth,
      height: 100.w,
      width: 100.w,
      imageUrl: path,
    ),
  );
}

class ExternalProfileProducts extends StatelessWidget {
  const ExternalProfileProducts({
    super.key,
    required this.externalProfileProducts,
  });

  final List<ProductModel> externalProfileProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.54,
      crossAxisSpacing: 20,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(externalProfileProducts.length, (index) {
        return PostCard(postCard: externalProfileProducts[index]);
      }),
    );
  }
}

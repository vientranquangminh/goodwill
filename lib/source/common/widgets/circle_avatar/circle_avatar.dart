import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:goodwill/source/resources/app_assets.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.size = const Size.square(110),
    this.imagePath,
  }) : super(key: key);

  final String? imagePath;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: CircleAvatar(
        // backgroundColor: Color(0xFF3D70B2),
        child: ClipOval(
          child: imagePath != null && imagePath!.isNotEmpty
              ? _netWorkAvatar()
              : _defaultAvatar(),
        ),
      ),
    );
  }

  Widget _netWorkAvatar() {
    return CachedNetworkImage(
      imageUrl: imagePath!,
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
      placeholder: (_, __) => _defaultAvatar(),
      errorWidget: (_, __, ___) => _defaultAvatar(),
    );
  }

  Widget _defaultAvatar() {
    return ColoredBox(
      color: const Color(0xFF3D70B2),
      child: Image.asset(
        AppAssets.icAvatarDefault,
        fit: BoxFit.cover,
        width: size.width,
        height: size.height,
      ),
    );
  }
}

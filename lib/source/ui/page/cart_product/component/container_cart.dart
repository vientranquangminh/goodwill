import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/ui/page/cart_product/cart_product.dart';

class ContainerCart extends StatelessWidget {
  const ContainerCart({
    super.key,
    required this.listCartProduct,
  });
  final ProductCartModel listCartProduct;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        Assets.images.raidenShogun.path,
                        width: 100,
                        height: 100,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              listCartProduct.title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: ColorName.black,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: listCartProduct.phoneNumber,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                          children: [
                            const TextSpan(
                              text: ' | ',
                            ),
                            TextSpan(
                              text: listCartProduct.location,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$" "${listCartProduct.price}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade300,
                                        radius: 20,
                                        child: Assets.svgs.message.svg())),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                    child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade300,
                                        radius: 20,
                                        child: const Icon(
                                          Icons.phone,
                                          color: Colors.black,
                                        )))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

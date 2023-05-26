import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/dto/cart_item_dto.dart';
import 'package:goodwill/source/service/cart_service.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:intl/intl.dart';

class ContainerCart extends StatefulWidget {
  const ContainerCart({
    super.key,
    required this.cartProduct,
    required this.index,
    required this.selectedIndexes,
    required this.quantity,
    this.onCheckboxChanged,
  });
  final CartItemDto cartProduct;
  final int index;
  final int quantity;
  final List<int> selectedIndexes;
  final ValueChanged<bool>? onCheckboxChanged;

  @override
  State<ContainerCart> createState() => _ContainerCartState();
}

class _ContainerCartState extends State<ContainerCart> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.selectedIndexes.contains(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = widget.selectedIndexes.contains(widget.index);
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
                    child: CachedNetworkImage(
                      imageUrl: widget.cartProduct.imageUrl,
                      width: 100.w,
                      height: 100.h,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.8,
                              child: Text(
                                widget.cartProduct.title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: ColorName.black,
                              ),
                              onPressed: () {
                                final cartItemId = widget.cartProduct.id;
                                CartService.deleteCartItemById(cartItemId);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "${widget.cartProduct.category} | ${widget.cartProduct.location}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "${context.localizations.quantity} : ${widget.quantity}",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "${NumberFormat('#,##0').format(widget.cartProduct.price)} ${Constant.VN_CURRENCY}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 8.w,
                                ),
                                Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    checkColor: Colors.white,
                                    activeColor: Colors.black,
                                    value: isChecked,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked = newValue ?? false;
                                        if (widget.onCheckboxChanged != null) {
                                          widget.onCheckboxChanged!(isChecked);
                                        }
                                      });
                                    },
                                  ),
                                )
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

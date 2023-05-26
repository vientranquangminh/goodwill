import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';

// ignore: must_be_immutable
class ContainerOfContent extends StatefulWidget {
  const ContainerOfContent({
    Key? key,
    required this.content,
  }) : super(key: key);

  final TextEditingController content;
  @override
  State<ContainerOfContent> createState() => _ContainerOfContentState();
}

class _ContainerOfContentState extends State<ContainerOfContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextFormField(
                minLines: 1,
                maxLines: null,
                controller: widget.content,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: context.localizations.writeSomething,
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

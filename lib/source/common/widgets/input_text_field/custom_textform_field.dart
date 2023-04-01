import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldForm extends StatefulWidget {
  const CustomTextFieldForm(
      {Key? key,
      this.label,
      this.labelStyle,
      this.description,
      this.descriptionStyle,
      this.initialValue,
      this.hintText = 'Please Enter',
      this.errorText,
      this.textStyle,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.textController,
      this.obscureText = false,
      this.enable = true,
      this.readyOnly = false,
      this.onChanged,
      this.onTap,
      this.autofillHints,
      this.onEditingComplete,
      this.outerPadding = EdgeInsets.zero,
      this.inputSize,
      this.globalKey})
      : super(key: key);

  final String? label;
  final TextStyle? labelStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? textController;
  final bool obscureText;
  final bool enable;
  final bool readyOnly;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final Iterable<String>? autofillHints;
  final Function()? onEditingComplete;
  final EdgeInsets outerPadding;
  final Size? inputSize;
  final GlobalKey? globalKey;

  @override
  State<CustomTextFieldForm> createState() => _CustomTextFieldFormState();
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.label != null)
            Text(
              widget.label!,
              style: widget.labelStyle ??
                  GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 14 / 12,
                    color:
                        Colors.black,
                  ),
            ),
          if (widget.label != null) const SizedBox(height: 4),
          SizedBox.fromSize(
            // size: widget.inputSize,
            child: TextFormField(
              controller: widget.textController,
              focusNode: _focusNode,
              initialValue: widget.initialValue,
              autofillHints: widget.autofillHints,
              onEditingComplete: widget.onEditingComplete,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              readOnly: widget.readyOnly,
              style: widget.textStyle ??
                  GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 16 / 14,
                    color:
                        Colors.black,
                  ),
              textInputAction: widget.textInputAction,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                fillColor: _focusNode.hasFocus
                    ? Colors.blue
                    : const Color(0xFFE6E6E6),
                hintText: widget.hintText,
                errorText: widget.errorText,
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 24,
                  maxWidth: 60,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: widget.suffixIcon,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: widget.enable,
            ),
          ),
          if (widget.description != null) const SizedBox(height: 4),
          if (widget.description != null)
            Text(
              widget.description!,
              style: widget.descriptionStyle ??
                  GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 14 / 12,
                    color: Colors.black,
                  ),
            ),
        ],
      ),
    );
  }
}

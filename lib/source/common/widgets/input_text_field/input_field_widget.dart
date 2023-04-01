import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({
    Key? key,
    required this.title,
    this.hintText,
    this.isPasswordField = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.enabled = true,
    this.enableSuffixIcon = false,
    this.initialValue,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.onTap,
    this.inputSize,
    this.outerPadding = EdgeInsets.zero,
    this.errorText,
    this.decoration,
    this.maxLines = 1,
    this.splashRadius = 1,
    this.suffixIconWidget,
  }) : super(key: key);
  final String title;
  final String? hintText;
  final bool isPasswordField;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final bool enabled;
  final bool enableSuffixIcon;
  final String? initialValue;
  final String? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final Function()? onTap;
  final String? errorText;
  final Size? inputSize;
  final EdgeInsets outerPadding;
  final InputDecoration? decoration;
  final int? maxLines;
  final double? splashRadius;
  final Widget? suffixIconWidget;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox.fromSize(
            size: widget.inputSize,
            child: TextFormField(
              maxLines: widget.maxLines,
              enabled: widget.enabled,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              controller: widget.controller,
              onChanged: widget.onChanged,
              validator: widget.validator,
              obscureText: widget.isPasswordField && !_isShowPassword,
              initialValue: widget.initialValue,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              decoration: widget.decoration ??
                  InputDecoration(
                    filled: true,
                    fillColor: widget.enabled
                        ? Colors.white
                        : Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          widget.enabled ? const BorderSide() : BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.enabled
                              ? Colors.grey
                              : Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(16, 11, 16, 13),
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: Colors.black, fontSize: 20),
                    errorStyle: const TextStyle(height: 0),
                    suffixIcon: widget.isPasswordField
                        ? IconButton(
                            splashRadius: widget.splashRadius,
                            onPressed: () {
                              setState(() {
                                _isShowPassword = !_isShowPassword;
                              });
                            },
                            icon: _isShowPassword
                                ? const Icon(Icons.visibility_outlined,
                                    color: Colors.blue)
                                : const Icon(Icons.visibility_off_outlined,
                                    color: Colors.blue),
                          )
                        : widget.suffixIcon != null
                            ? IconButton(
                                splashColor: Colors.transparent,
                                onPressed: widget.enableSuffixIcon
                                    ? widget.onTapSuffixIcon
                                    : null,
                                icon: Image.asset(widget.suffixIcon!),
                              )
                            : widget.suffixIconWidget != null
                                ? IconButton(
                                    splashColor: Colors.transparent,
                                    onPressed: widget.enableSuffixIcon
                                        ? widget.onTapSuffixIcon
                                        : null,
                                    icon: widget.suffixIconWidget!,
                                  )
                                : null,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:notes_app/common_imports.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? rightSideText;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType inputType;
  final String hint;
  final bool obsecure;
  final bool hasError;
  final String? errorText;
  final Widget? suffix;
  final Widget? prefix;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String text)? onTextChange;
  final bool autoCorrect;
  final bool readOnly;
  final double borderRadius;
  final int maxLines;

  const CustomTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    required this.label,
    this.rightSideText,
    required this.hint,
    this.suffix,
    this.prefix,
    this.onTextChange,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.obsecure = false,
    this.hasError = false,
    this.errorText,
    this.inputType = TextInputType.text,
    this.inputFormatters,
    this.autoCorrect = false,
    this.borderRadius = 16,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HomeiLabelTextWidget(label: label, rightSideText: rightSideText),
        // spaceV1,
        _textField(),
        (hasError && errorText.isNotNullOrEmpty()) ? context.spaceV1 : noWidget,
        (hasError && errorText.isNotNullOrEmpty())
            ? Text(
                errorText!,
                style: PoppinsStyle.textStyle12w400.copyWith(color: Colors.red),
              )
            : noWidget
      ],
    );
  }

  Widget _textField() {
    return ClipRRect(
      borderRadius: 8.toRadius(),
      child: TextField(
        readOnly: readOnly,
        autocorrect: autoCorrect,
        controller: controller,
        focusNode: focusNode,
        keyboardType: inputType,
        maxLines: maxLines,
        obscureText: obsecure,
        inputFormatters: inputFormatters,
        style: PoppinsStyle.textStyle14w400,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        onChanged: onTextChange,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius.toRadius(),
                borderSide: BorderSide(
                    color: hasError
                        ? Colors.red
                        : AppColors.colorTextFieldOutline)),
            border: OutlineInputBorder(
                borderRadius: borderRadius.toRadius(),
                borderSide: BorderSide(
                    color: hasError
                        ? Colors.red
                        : AppColors.colorTextFieldOutline)),
            enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius.toRadius(),
                borderSide: BorderSide(
                    color: hasError
                        ? Colors.red
                        : AppColors.colorTextFieldOutline)),
            fillColor: Colors.white,
            filled: true,
            hintText: hint,
            hintStyle: PoppinsStyle.textStyle16w400
                .copyWith(color: Colors.grey.shade600),
            suffixIcon: (suffix != null) ? suffix : null,
            prefixIcon: (prefix != null) ? prefix : null,
            suffixIconConstraints: null),
      ),
    );
  }
}

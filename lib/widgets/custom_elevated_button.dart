import 'package:auto_size_text/auto_size_text.dart';
import 'package:notes_app/common_imports.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final double radius;
  final bool isEnabled;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? textColor;

  final Color? iconColor;
  final double? textWidth;

  CustomElevatedButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.radius = 16,
    this.isEnabled = true,
    this.enabledColor,
    this.disabledColor = AppColors.colorDisabled,
    this.width = double.maxFinite,
    this.height = 56,
    this.textColor = Colors.white,
    this.iconColor,
    this.textWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          // backgroundColor: isEnabled
          //     ? (enabledColor ?? AppColors.colorPrimary)
          //     : disabledColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          shape: radius.toRoundedRectRadius(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: textWidth,
              child: AutoSizeText(
                text,
                minFontSize: 8,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RobotoStyle.buttonsTextStyle.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

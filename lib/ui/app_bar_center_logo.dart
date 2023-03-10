import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/colors.dart';
import '../helpers/quick_help.dart';

class ToolBarCenterLogo extends StatelessWidget {
  final Function? leftButtonPress;
  final IconData? leftButtonIcon;
  final String? leftButtonAsset;
  final Widget? leftButtonWidget;
  final Color? leftIconColor;
  final Function? rightButtonPress;
  final IconData? rightButtonIcon;
  final String? rightButtonAsset;
  final Color? rightIconColor;
  final Function? afterLogoButtonPress;
  final IconData? afterLogoButtonIcon;
  final String? afterLogoButtonAsset;
  final Color? afterLogoIconColor;
  final String logoName;
  final Widget child;
  final double? logoWidth;
  final double? logoHeight;
  final double? elevation;
  final double? leadingWidth;
  final Widget? bottomNavigationBar;
  final double? iconWidth;
  final double? iconHeight;
  final Color? backGroundColor;
  final bool? extendBodyBehindAppBar;
  final bool? isShowLeading;

  const ToolBarCenterLogo(
      {Key? key,
      required this.logoName,
      required this.child,
      this.logoWidth,
      this.logoHeight,
      this.iconWidth,
      this.iconHeight,
      this.leftButtonIcon,
      this.isShowLeading,
      this.leftButtonPress,
      this.leftIconColor,
      this.rightButtonPress,
      this.rightButtonIcon,
      this.rightIconColor,
      this.afterLogoButtonPress,
      this.afterLogoButtonIcon,
      this.afterLogoIconColor,
      this.elevation,
      this.bottomNavigationBar,
      this.afterLogoButtonAsset,
      this.leftButtonAsset,
      this.leftButtonWidget,
      this.backGroundColor,
      this.leadingWidth,
      this.extendBodyBehindAppBar = false,
      this.rightButtonAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color titleColor = QuickHelp.isDarkModeNoContext()
        ? kContentColorDarkTheme
        : kContentColorLightTheme;

    Color bgColor = QuickHelp.isDarkModeNoContext()
        ? kContentColorLightTheme
        : kContentColorDarkTheme;

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar!,
      appBar: AppBar(
        leadingWidth: leadingWidth != null ? leadingWidth : null,
        leading: (isShowLeading == null)
            ? (leftButtonWidget != null
                ? leftButtonWidget
                : IconButton(
                    icon: leftButtonAsset != null
                        ? leftButtonAsset!.endsWith(".svg")
                            ? SvgPicture.asset("assets/svg/$leftButtonAsset",
                                width: iconWidth,
                                height: iconHeight,
                                color: leftIconColor != null
                                    ? leftIconColor
                                    : null)
                            : Image.asset(
                                "assets/image/$leftButtonAsset",
                                width: iconWidth,
                                height: iconHeight,
                              )
                        : Icon(leftButtonIcon,
                            color: leftIconColor != null
                                ? leftIconColor
                                : titleColor),
                    onPressed: leftButtonPress != null
                        ? leftButtonPress as void Function()?
                        : () => Navigator.of(context).pop(),
                  ))
            : SizedBox(),
        backgroundColor: backGroundColor != null ? backGroundColor : bgColor,
        title: Image.asset("assets/images/$logoName",
            width: logoWidth, height: logoHeight),
        centerTitle: true,
        //bottomOpacity: 10,
        elevation: elevation,
        actions: [
          IconButton(
            icon: afterLogoButtonAsset != null
                ? SvgPicture.asset("assets/svg/$afterLogoButtonAsset",
                    width: iconWidth,
                    height: iconHeight,
                    color: afterLogoIconColor != null
                        ? afterLogoIconColor
                        : titleColor)
                : Icon(afterLogoButtonIcon,
                    color: afterLogoIconColor != null
                        ? afterLogoIconColor
                        : titleColor),
            onPressed: afterLogoButtonPress as void Function()?,
          ),
          IconButton(
            icon: rightButtonAsset != null
                ? SvgPicture.asset("assets/svg/$rightButtonAsset",
                    width: iconWidth,
                    height: iconHeight,
                    color: rightIconColor != null ? rightIconColor : titleColor)
                : Icon(rightButtonIcon,
                    color:
                        rightIconColor != null ? rightIconColor : titleColor),
            onPressed: rightButtonPress as void Function()?,
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: child,

      /*body: Builder(builder: (BuildContext context) {
        return child;
      }),*/
    );
  }
}

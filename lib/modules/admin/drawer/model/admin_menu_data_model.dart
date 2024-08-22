class AdminMenuDataModel {
  String prefixSvgIcon;
  String menuName;
  bool isShowRightIcon;
  double? svgIconHeight;
  double? svgIconWidth;

  AdminMenuDataModel({
    required this.prefixSvgIcon,
    required this.menuName,
    this.isShowRightIcon = true,
    this.svgIconWidth,
    this.svgIconHeight,
  });
}

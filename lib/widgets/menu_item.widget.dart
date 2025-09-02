import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.extras,
    this.color = appSecondaryColor,
    this.directChild,
    required this.onPressed,
    this.textColor = Colors.grey,
  });

  final String icon;
  final String title;
  final String description;
  final String? extras;
  final Color? color;
  final Widget? directChild;
  final Function onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: 26,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: likeBlueColor,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(color: textColor, fontSize: 13.5),
                        overflow: TextOverflow.ellipsis,
                      ),
                      extras != null
                          ? Text(
                              extras!,
                              style:
                                  TextStyle(color: textColor, fontSize: 13.5),
                              overflow: TextOverflow.ellipsis,
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          ),
          directChild ??
              SvgPicture.asset(
                arrowRight,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
        ],
      ),
    );
  }
}

class ConfigItem extends StatelessWidget {
  const ConfigItem({
    super.key,
    required this.title,
    required this.description,
    this.directChild,
    required this.onPressed,
  });

  final String title;
  final String description;
  final Widget? directChild;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: likeBlueColor, fontSize: 15),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey, fontSize: 13.5),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          directChild ??
              SvgPicture.asset(
                arrowRight,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
        ],
      ),
    );
  }
}

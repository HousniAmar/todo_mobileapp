import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List icons;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.icons,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = 10.0; // Match this with your horizontal padding
    final availableWidth = MediaQuery.of(context).size.width - (padding * 2);
    final itemWidth = availableWidth / icons.length;
    final indicatorWidth = 60.0;
    final navItemWidth = 70.0; // Width of the nav item

    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Stack(
          children: [
            // Animated indicator
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutExpo,
              tween: Tween<double>(
                begin: _calculateIndicatorPosition(
                  selectedIndex,
                  itemWidth,
                  indicatorWidth,
                ),
                end: _calculateIndicatorPosition(
                  selectedIndex,
                  itemWidth,
                  indicatorWidth,
                ),
              ),
              builder: (context, value, child) {
                return Positioned(
                  left: value,
                  top: 0,
                  child: Container(
                    width: indicatorWidth,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      // borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              },
            ),
            // Nav items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                icons.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Calculate the centered position for the indicator
  double _calculateIndicatorPosition(
    int index,
    double itemWidth,
    double indicatorWidth,
  ) {
    // Center the indicator under the item
    return (index * itemWidth) + (itemWidth / 2) - (indicatorWidth / 2);
  }

  Widget _buildNavItem(int index) {
    bool isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onItemSelected(index),
      child: SizedBox(
        width: 70, // This should match navItemWidth in build()
        height: 80,
        child: Icon(
          icons[index],
          color: isSelected ? Colors.blue : Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}

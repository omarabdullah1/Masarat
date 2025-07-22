import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    required this.items,
    super.key,
    this.hintText = 'Select Item',
    this.onChanged,
    this.height = 50.0,
    this.width = 160.0,
    this.iconColor = Colors.black,
    this.buttonColor = Colors.white,
    this.textColor = Colors.black,
    this.dropdownColor = Colors.white,
    this.selectedValue,
  });
  final List<String> items;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final double height;
  final double width;
  final Color iconColor;
  final Color buttonColor;
  final Color textColor;
  final Color dropdownColor;
  final String? selectedValue; // Current selected value

  @override
  Widget build(BuildContext context) {
    // Debug print to see what value is being set
    debugPrint('Building dropdown with selected value: $selectedValue');

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black26),
        color: buttonColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: items.contains(selectedValue) ? selectedValue : null,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: iconColor,
            size: 14,
          ),
          hint: Text(
            hintText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: dropdownColor,
          elevation: 0,
        ),
      ),
    );
  }
}

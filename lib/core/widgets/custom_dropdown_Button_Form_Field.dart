// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final double height;
  final double width;
  final Color iconColor;
  final Color buttonColor;
  final Color textColor;
  final Color dropdownColor;

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
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items.map((String item) {
          return DropdownItem<String>(
            value: item,
            height: height,
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
        buttonStyleData: ButtonStyleData(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black26),
            color: buttonColor,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          iconSize: 14,
          iconEnabledColor: iconColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: dropdownColor,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 14),
        ),
      ),
    );
  }
}

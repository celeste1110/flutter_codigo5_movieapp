import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemFilterWidget extends StatelessWidget {
  String textFilter;
  bool isSelected;
  Function onTap;
  ItemFilterWidget({
    required this.textFilter,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff23dec3) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xff23dec3) : Colors.white70,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Color(0xff23dec3).withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ]
              : [],
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff5de09c),
                    Color(0xff23dec3),
                  ],
                )
              : null,
        ),
        child: Text(
          textFilter,
          style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';

class SpecialtyPriority extends StatefulWidget {
  final Function(int priority) onPriorityChanged;

  SpecialtyPriority({required this.onPriorityChanged});

  @override
  _SpecialtyPriorityState createState() => _SpecialtyPriorityState();
}

class _SpecialtyPriorityState extends State<SpecialtyPriority> {
  int _priority = 0;

  void _setPriority(int newPriority) {
    setState(() {
      _priority = newPriority;
    });
    widget.onPriorityChanged(_priority);
  }

  @override
  Widget build(BuildContext context) {
    List<String> priorityTexts = ['First', 'Second', 'Third'];
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 1; i <= 3; i++)
          GestureDetector(
            onTap: () => _setPriority(i),
            child: Container(
              height: size.height * 0.074,
              width: size.width * 0.28,
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor,
                border: Border.all(
                  color: _priority == i
                      ? AppColors.lightPurpleColor
                      : AppColors.lightGreyColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  priorityTexts[i - 1],
                  style: ConstructorTextStyle.priority,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

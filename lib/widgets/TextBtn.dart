import 'package:flutter/material.dart';

class TextBtn extends StatefulWidget {
  const TextBtn({super.key});

  @override
  State<TextBtn> createState() => _TextBtnState();
}

class _TextBtnState extends State<TextBtn> {
  var isHover = false;
  _onHoverBtn() {
    setState(() {
      isHover = !isHover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          _onHoverBtn();
          print('tapped');
        },
        child: Text(
          'text',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isHover
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

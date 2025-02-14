import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildOption extends StatefulWidget {
  final String text;
  const BuildOption({super.key, required this.text});

  @override
  State<BuildOption> createState() => _BuildOptionState();
}

class _BuildOptionState extends State<BuildOption> {
  bool _isSelected = false;
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },

      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.purple[100] : Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.text, style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500)),
              Icon(
                  _isSelected
                      ? CupertinoIcons.check_mark_circled_solid
                      : CupertinoIcons.circle,
                  color: Colors.purple,
                  size: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}


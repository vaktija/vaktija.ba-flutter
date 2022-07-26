import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

class ChooseWheel extends StatefulWidget {
  final initIndex;
  final length;
  final isMonth;
  final offset;
  final onChangeValue;
  final isHijri;

  const ChooseWheel(
      {Key? key,
      this.initIndex,
      this.length,
      this.isMonth,
      this.offset,
      this.onChangeValue,
      this.isHijri})
      : super(key: key);

  @override
  _ChooseWheelState createState() => _ChooseWheelState();
}

class _ChooseWheelState extends State<ChooseWheel> {
  late FixedExtentScrollController _listItemController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = widget.initIndex;
    });
    _listItemController =
        FixedExtentScrollController(initialItem: widget.initIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _listItemController.dispose();
  }

  void jumpToItem(index) {
    _listItemController.animateToItem(index,
        duration: Duration(milliseconds: 10), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    bool isMonth = widget.isMonth ?? false;
    bool isHijri = widget.isHijri ?? false;
    if (currentIndex >= widget.length) {
      jumpToItem(widget.length - 1);
    }

    return Container(
      width: widget.isMonth ? 170 : 70,
      height: 200,
      child: ListWheelScrollView(
        useMagnifier: true,
        //true,
        itemExtent: 30,
        controller: _listItemController,
        physics: FixedExtentScrollPhysics(),
        magnification: 1.1,
        diameterRatio: 1.1,
        offAxisFraction: widget.offset ?? 0.0,
        perspective: 0.006,
        squeeze: 1.3,
        renderChildrenOutsideViewport: false,
        onSelectedItemChanged: (index) {
          if (isHijri && !isMonth) {
            if(index < 1360){
              _listItemController.animateToItem(1359,
                  duration: Duration(milliseconds: 10), curve: Curves.easeInOut);
            }
            if (index > 1355) {
              widget.onChangeValue(index);
            }
          } else {
            widget.onChangeValue(index);
          }
          setState(() {
            currentIndex = index;
          });
        },
        children: List.generate(
            widget.length,
            (index) => _scrollItem(
                  index: index,
                  isMonth: isMonth,
                  isHijri: widget.isHijri ?? false,
                  isSelected: index == currentIndex ? true : false,
                )),
      ),
    );
  }
}

class _scrollItem extends StatelessWidget {
  final index;
  final isSelected;
  final isMonth;
  final isHijri;

  const _scrollItem(
      {Key? key, this.index, this.isSelected, this.isMonth, this.isHijri})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    final List mjeseci = isHijri ? mjeseciHidz : mjeseciFullName;
    return Center(
      child: Text(
        isMonth ? mjeseci[index] : (index + 1).toString().padLeft(2, '0'),
        textScaleFactor: 1.0,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? (isDarkModeOn ? Colors.white : colorTitle)
                : colorSubtitle),
      ),
    );
  }
}

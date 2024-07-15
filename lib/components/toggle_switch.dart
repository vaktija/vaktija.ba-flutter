import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/data/data.dart';

class ToggleSwitch extends StatefulWidget {
  final isToggle;
  final onTap;

  const ToggleSwitch({Key? key, this.isToggle, this.onTap}) : super(key: key);

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {

  //int isOn = 1;
  Size get s => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    int isOn = widget.isToggle ? 1 : 0;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 51, //s.width / 4,
        height: 31, //(s.width / 4) * 120 / 236,
        decoration: BoxDecoration(
          color: AppColors.colorSubtitle, // Color(0xffDDE1E3),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 480),
                curve: Curves.bounceOut,
                width: 31 + (20.0 * isOn),
                height: 31,
                decoration: BoxDecoration(
                  color: isOn != 0 ? AppColors.colorSwitchActive : AppColors.colorSubtitle,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 480),
              curve: Curves.bounceOut,
              top: 2,
              left: 2 + (20.0 * isOn),
              child: Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        offset: Offset(0,3)
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

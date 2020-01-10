import 'package:creditcard_neumorphism/widgets/nm_box.dart';
import 'package:flutter/widgets.dart';

class NMButton extends StatefulWidget {
  const NMButton({
    this.width = 55,
    this.height = 55,
    this.alignmentDirectional = AlignmentDirectional.center,
    this.icon,
    this.iconSize = 22,
    this.radius = 15,
    this.child,
    this.onTap,
  });

  final double width;
  final double height;
  final AlignmentDirectional alignmentDirectional;
  final IconData icon;
  final double iconSize;
  final double radius;
  final Widget child;
  final Function onTap;

  @override
  _NMButtonState createState() => _NMButtonState();
}

class _NMButtonState extends State<NMButton> {
  bool _down = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      // Press
      onTapDown: (_) {
        setState(() {
          _down = widget.onTap != null && true;
        });
      },
      // Release
      onTapUp: (_) {
        setState(() {
          _down = widget.onTap != null && false;
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: _down
            ? nMboxInvert(radius: widget.radius)
            : nMbox(radius: widget.radius),
        child: Stack(
          alignment: widget.alignmentDirectional,
          children: <Widget>[
            widget.child ?? Container(),
            Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: _down ? fCD : fCL,
                ) ??
                Container(),
          ],
        ),
      ),
    );
  }
}

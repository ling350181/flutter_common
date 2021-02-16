import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TapRippleWideget extends StatefulWidget {
  Color color;
  Color tapColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final List<BoxShadow> boxShadow;
  final BorderRadiusGeometry borderRadius;
  final bool showBottomBorder;
  final BoxBorder boxBorder;
  final Widget child;

  TapRippleWideget(
      {this.child,
      this.color,
      this.tapColor,
      this.margin,
      this.padding,
      this.boxShadow,
      this.borderRadius,
      this.showBottomBorder = false,
      this.boxBorder});
  @override
  _TapComponentState createState() => _TapComponentState();
}

class _TapComponentState extends State<TapRippleWideget> {
  @override
  Widget build(BuildContext context) {
    //Color _color;
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
          color: widget.color,
          boxShadow: widget.boxShadow,
          borderRadius: widget.borderRadius, // 圆角度
          border: widget.showBottomBorder
            ? widget.boxBorder ?? Border(bottom: BorderSide(color: Colors.grey[200]))
            : null
      ),
      child: GestureDetector(
        onTapDown: (_) {
          widget.color = widget.tapColor ?? Color.fromRGBO(229, 229, 229, 1);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (this.mounted) setState(() {});
          });
        },
        onTapUp: (_) {
          widget.color = Colors.white;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (this.mounted) setState(() {});
          });
        },
        onTapCancel: () {
          widget.color = Colors.white;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (this.mounted) setState(() {});
          });
        },
        child: widget.child,
      ),
    );
  }
}

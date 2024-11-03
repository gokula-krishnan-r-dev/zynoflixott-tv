// ignore: file_names
// ignore: file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Duration duration;
  final Color? activeColor;

  const FlutterSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.duration = const Duration(milliseconds: 370),
    this.activeColor,
  });
  @override
  State<StatefulWidget> createState() => _FlutterSwitchState();
}

class _FlutterSwitchState extends State<FlutterSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  final focusNode = FocusNode();
  bool switchState = false;
  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));

    switchState = widget.value;
    // _setKnobPosition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('dependencyChanged ${widget.value}');
  }

  @override
  void didUpdateWidget(covariant FlutterSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      switchState = widget.value;
    }
  }

  Color getActiveColor(BuildContext context) {
    return widget.activeColor ?? Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Focus(
          focusNode: focusNode,
          onFocusChange: (value) => log('focusChanged ${value}'),
          onKey: (node, event) {
            log('focusChanged Enter key pressed event: ${event} ${event is RawKeyDownEvent} ${event.logicalKey.keyId == LogicalKeyboardKey.select.keyId} eventkey: ${event.logicalKey} select:${LogicalKeyboardKey.select}');
            if (event is RawKeyDownEvent) {
              if (event.logicalKey.keyId == LogicalKeyboardKey.select.keyId) {
                log('focusChanged Enter key pressed');
                _toggle();
                return KeyEventResult.handled;
              }
            }
            return KeyEventResult.ignored;
          },
          child: GestureDetector(
            onTap: _toggle,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 32.0,
                        height: 18.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: !switchState
                              ? Colors.grey.withAlpha(50)
                              : getActiveColor(context).withAlpha(50),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 36.0,
                    height: 28.0,
                    alignment: widget.value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !switchState
                            ? Colors.white
                            : getActiveColor(context),
                        boxShadow: switchState
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: Offset(2, 4),
                                  blurRadius: 5,
                                ),
                              ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _toggle() {
    setState(() {
      switchState = !switchState;
    });
    _setKnobPosition();
  }

  _setKnobPosition() {
    (switchState)
        ? _animationController?.forward()
        : _animationController?.reverse();

    widget.onChanged(switchState);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

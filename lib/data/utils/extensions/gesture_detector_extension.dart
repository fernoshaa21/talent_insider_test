import 'package:flutter/material.dart';

extension BouncingGestureDetector on GestureDetector {
  Widget bounce(
      {double scale = 0.8,
      Duration duration = const Duration(milliseconds: 100)}) {
    bool isPressed = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTapDown: (details) {
            setState(() => isPressed = true);
            if (onTapDown != null) onTapDown!(details);
          },
          onTapUp: (details) {
            Future.delayed(duration, () {
              setState(() => isPressed = false);
            });
            if (onTapUp != null) onTapUp!(details);
          },
          onTapCancel: () {
            Future.delayed(duration, () {
              setState(() => isPressed = false);
            });
            if (onTapCancel != null) onTapCancel!();
          },
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onLongPressStart: onLongPressStart,
          onLongPressMoveUpdate: onLongPressMoveUpdate,
          onLongPressUp: onLongPressUp,
          onLongPressEnd: onLongPressEnd,
          onSecondaryTap: onSecondaryTap,
          onSecondaryTapDown: onSecondaryTapDown,
          onSecondaryTapUp: onSecondaryTapUp,
          onSecondaryTapCancel: onSecondaryTapCancel,
          onTertiaryTapDown: onTertiaryTapDown,
          onTertiaryTapUp: onTertiaryTapUp,
          onTertiaryTapCancel: onTertiaryTapCancel,
          onSecondaryLongPress: onSecondaryLongPress,
          onSecondaryLongPressStart: onSecondaryLongPressStart,
          onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
          onSecondaryLongPressUp: onSecondaryLongPressUp,
          onSecondaryLongPressEnd: onSecondaryLongPressEnd,
          onTertiaryLongPress: onTertiaryLongPress,
          onTertiaryLongPressStart: onTertiaryLongPressStart,
          onTertiaryLongPressMoveUpdate: onTertiaryLongPressMoveUpdate,
          onTertiaryLongPressUp: onTertiaryLongPressUp,
          onTertiaryLongPressEnd: onTertiaryLongPressEnd,
          behavior: behavior,
          dragStartBehavior: dragStartBehavior,
          excludeFromSemantics: excludeFromSemantics,
          key: key,
          onForcePressPeak: onForcePressPeak,
          onForcePressStart: onForcePressStart,
          onForcePressEnd: onForcePressEnd,
          onPanDown: onPanDown,
          onPanStart: onPanStart,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
          onPanCancel: onPanCancel,
          onScaleStart: onScaleStart,
          onScaleUpdate: onScaleUpdate,
          onScaleEnd: onScaleEnd,
          onHorizontalDragDown: onHorizontalDragDown,
          onHorizontalDragStart: onHorizontalDragStart,
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onHorizontalDragEnd: onHorizontalDragEnd,
          onHorizontalDragCancel: onHorizontalDragCancel,
          onVerticalDragDown: onVerticalDragDown,
          onVerticalDragStart: onVerticalDragStart,
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: onVerticalDragEnd,
          onVerticalDragCancel: onVerticalDragCancel,
          onForcePressUpdate: onForcePressUpdate,
          onDoubleTapCancel: onDoubleTapCancel,
          onDoubleTapDown: onDoubleTapDown,
          onLongPressCancel: onLongPressCancel,
          onLongPressDown: onLongPressDown,
          onSecondaryLongPressCancel: onSecondaryLongPressCancel,
          onSecondaryLongPressDown: onSecondaryLongPressDown,
          onTertiaryLongPressCancel: onTertiaryLongPressCancel,
          onTertiaryLongPressDown: onTertiaryLongPressDown,
          supportedDevices: supportedDevices,
          trackpadScrollCausesScale: trackpadScrollCausesScale,
          trackpadScrollToScaleFactor: trackpadScrollToScaleFactor,
          child: AnimatedScale(
              curve: Curves.easeInOut,
              scale: isPressed ? scale : 1,
              duration: duration,
              child: child),
        );
      },
    );
  }
}

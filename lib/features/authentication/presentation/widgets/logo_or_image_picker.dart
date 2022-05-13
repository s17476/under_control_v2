import 'dart:io';

import 'package:flutter/material.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';

import '../../../core/presentation/widgets/logo_widget.dart';
import 'user_image_picker.dart';

class LogoOrImagePicker extends StatefulWidget {
  const LogoOrImagePicker({Key? key, required this.isInLoginMode})
      : super(key: key);

  final bool isInLoginMode;

  @override
  State<LogoOrImagePicker> createState() => _LogoOrImagePickerState();
}

class _LogoOrImagePickerState extends State<LogoOrImagePicker>
    with ResponsiveSize, SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;
  Animation<double>? _opacityAnimationBackward;
  File? _userImageFile;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    ));
    _opacityAnimationBackward =
        Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    ));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
  }

  void _pickImage(File? image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isInLoginMode) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
    return SizedBox(
      height: responsiveSizePx(small: 180),
      child: widget.isInLoginMode
          ? FadeTransition(
              opacity: _opacityAnimationBackward!,
              child: Logo(
                greenLettersSize: responsiveSizePx(small: 18, medium: 12),
                whitheLettersSize: responsiveSizePx(small: 12, medium: 8),
              ),
            )
          : FadeTransition(
              opacity: _opacityAnimation!,
              child: UserImagePicker(
                imagePickFn: _pickImage,
                image: _userImageFile,
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/theme/theme_bloc.dart';
import '../../../core/constant/colors.dart';
import '../../../core/constant/theme.dart';

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key, 
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late LinearGradient linearGradient;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));

    linearGradient = context.read<ThemeBloc>().state.currentTheme ==
            kAppThemeData[AppTheme.light]!
        ? kLightShimmerGradient
        : kDarkShimmerGradient;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _shimmerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
        colors: linearGradient.colors,
        stops: linearGradient.stops,
        begin: linearGradient.begin,
        end: linearGradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: widget.child,
    );
  }
}

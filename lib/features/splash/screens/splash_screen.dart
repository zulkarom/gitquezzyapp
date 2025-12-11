import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ta_plus/features/reusable/widgets/taplus_loader.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/show_snackbar.dart';
import '../../reusable/widgets/custom_snack_bar.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatefulWidget {
  const _Scaffold();

  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: (7)));
    context.read<SplashBloc>().add(const InitScreen());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashInitSucceed) {
          // Future.delayed(const Duration(seconds: 2), () {
          //   // Navigator.of(context)
          //   //     .pushNamedAndRemoveUntil(RouteGenerator.welcome, (_) => false);
          //   Navigator.of(context)
          //       .pushNamedAndRemoveUntil("/welcome", (route) => false);
          // });
        } else if (state is SplashInitFailed) {
          showSnackBar(
              context,
              customSnackBar(
                content:
                    'Please connect to internet (${state.failure.errorMessage})',
                context: context,
              ));
        } else if (state is NetworkUpdated) {
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil(RouteGenerator.login, (_) => false);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/login", (route) => false);
        }
      },
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xffF7F7F7),
            body: Lottie.asset('assets/images/logo/quezzySplash.json',
                controller: _controller,
                height: MediaQuery.of(context).size.height * 1,
                animate: true, onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(() => Navigator.of(context)
                    .pushNamedAndRemoveUntil("/welcome", (route) => false));
            }),
          );
        },
      ),
    );
  }
}

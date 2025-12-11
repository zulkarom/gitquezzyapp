import 'package:flutter/material.dart';
import 'package:flutter_ta_plus/features/student/screens/forget_pin_form.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';

class ForgetPinScreen extends StatefulWidget {
  const ForgetPinScreen({super.key});

  @override
  State<ForgetPinScreen> createState() => _ForgetPinScreenState();
}

class _ForgetPinScreenState extends State<ForgetPinScreen> {
  Object? type;
  late Set<Map<String, Object?>> studentData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentData =
        ModalRoute.of(context)!.settings.arguments as Set<Map<String, Object?>>;

    for (var data in studentData) {
      type = data["type"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Forget Pin',
            leading: [
              Center(
                child: CustomIconButton(
                  onTap: () {
                    if (type == 2) {
                      // Navigator.pop(context);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/application",
                        (route) => false,
                      );
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/app_parent", (route) => false);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: AppDimension().kTwentyScreenPixel,
                    color:
                        Theme.of(context).appBarTheme.actionsIconTheme!.color,
                  ),
                ),
              )
            ],
          ),
          const ForgetPinForm(),
        ],
      ),
    ));
  }
}

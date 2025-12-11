import 'package:flutter/material.dart';
import 'package:flutter_ta_plus/features/student/screens/student_form.dart';
import '../../../core/constant/app_dimensions.dart';
import '../../reusable/widgets/custom_app_bar.dart';
import '../../reusable/widgets/custom_icon_button.dart';

class StudentEditScreen extends StatelessWidget {
  const StudentEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Edit Student',
            leading: [
              Center(
                child: CustomIconButton(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/student_list_edit", (route) => false);
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
          const StudentForm(2),
        ],
      ),
    ));
  }
}

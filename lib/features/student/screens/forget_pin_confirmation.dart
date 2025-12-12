import 'package:flutter/material.dart';
import 'package:quezzy_app/features/reusable/widgets/parent_password_field.dart';
import 'package:quezzy_app/features/student/controller/student_controller.dart';

class ForgetPinConfirmation extends StatelessWidget {
  final int? studentId;
  final String? name;
  final int? type;
  final String? pin;
  final int? menuType;
  const ForgetPinConfirmation(
      this.studentId, this.name, this.type, this.pin, this.menuType,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return _Content(studentId, name, type, pin, menuType);
  }
}

class _Content extends StatefulWidget {
  final int? studentId;
  final String? name;
  final int? type;
  final String? pin;
  final int? menuType;
  const _Content(this.studentId, this.name, this.type, this.pin, this.menuType);

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ParentPasswordField(
      passwordHandler: (String password) {
        // Accepts a String parameter

        StudentController(context: context).asyncPostResetPinNumber(
          widget.studentId!,
          widget.pin!,
          password,
          widget.type!,
        );
      },
    );
  }
}

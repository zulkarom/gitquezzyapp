import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_ta_plus/features/profile/controllers/profile_controller.dart';
import 'package:flutter_ta_plus/features/student/widgets/student_widget.dart';

import '../../../core/models/entities.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key, required this.avatarItem});
  final List<AvatarItem> avatarItem;

  @override
  Widget build(BuildContext context) {
    return _Content(avatarItem);
  }
}

class _Content extends StatefulWidget {
  const _Content(this.avatarItem);
  final List<AvatarItem> avatarItem;
  @override
  State<_Content> createState() => _StudentAvatarScreenState();
}

class _StudentAvatarScreenState extends State<_Content> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProfileController(context: context).initAvatar();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            "Sila pilih avatar anda",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
            // TextStyle(
            //     fontSize: 14.sp, color: AppColors.primaryElementText),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ProfileBloc>().add(
                                  AvatarUrlEvent(
                                    widget.avatarItem.elementAt(index).url!,
                                  ),
                                );

                            Navigator.pop(context);
                          },
                          child: avatarGrid(widget.avatarItem[index]),
                        );
                      },
                      childCount: widget.avatarItem.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

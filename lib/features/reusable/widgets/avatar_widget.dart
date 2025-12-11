import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ta_plus/features/profile/bloc/profile_bloc.dart';
import 'package:flutter_ta_plus/features/student/widgets/student_widget.dart';

import '../../../core/models/entities.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(
      {super.key, required this.avatarItem, required this.tapHandler});
  final List<AvatarItem> avatarItem;
  final void Function()? tapHandler;

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
                                    avatarItem.elementAt(index).url!,
                                  ),
                                );
                          },
                          child: avatarGrid(avatarItem[index]),
                        );
                      },
                      childCount: avatarItem.length,
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

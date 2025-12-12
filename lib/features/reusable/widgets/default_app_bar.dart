import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quezzy_app/core/bloc/theme/theme_bloc.dart';
import 'package:quezzy_app/features/reusable/widgets/circle_gradient_icon.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData iconData;
  final int type;
  const DefaultAppBar({super.key, required this.iconData, required this.type});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      title: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Container(
            height: size.height * .07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: state.currentTheme.brightness == Brightness.light
                    ? const ExactAssetImage('assets/mainMenu.png')
                    : const ExactAssetImage('assets/mainMenu_dm.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        },
      ),
      leading: IconButton(
        icon: Icon(
          iconData,
          color: Theme.of(context).canvasColor,
        ), // Use any icon for the drawer toggle button
        onPressed: () {
          if (type == 1) {
            Scaffold.of(context).openDrawer();
          } else {
            Navigator.pop(context);
          }

          // Open the drawer
        },
      ),
      elevation: 0,
      actions: [
        PopupMenuButton<int>(
          color: Theme.of(context).dialogBackgroundColor,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CircleGradientIcon(
              icon: Icons.more_horiz,
              color: Colors.blue,
              iconSize: 24,
              size: 40,
            ),
          ),
          // onSelected: (item) => onSelected(context, item),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('About'),
            ),
            PopupMenuItem(
              child: const Text('Exit'),
              onTap: () {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                        'Adakah anda pasti ingin keluar?',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text(
                            'TIDAK',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: Text(
                            'YA',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

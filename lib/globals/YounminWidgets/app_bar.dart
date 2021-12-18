import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';

class CustomAppBarWithBackActionButton extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithBackActionButton({
    Key? key,
    this.actions,
    this.backButtonAction,
  }) : super(key: key);

  final List<Widget>? actions;
  final Function()? backButtonAction;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 90,
      leadingWidth: 100,
      leading: Row(
        children: [
          Container(
            width: 14,
          ),
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            color: Colors.white,
            onPressed: backButtonAction != null
                ? backButtonAction!
                : () {
                    FocusScope.of(context).unfocus();
                    context.router.pop();
                  },
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: YounminColors.lightBlack,
      title: const LogoButton(
        navigateOnTap: false,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

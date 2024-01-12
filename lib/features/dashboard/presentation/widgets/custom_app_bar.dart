import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_customer/common/services/location_service.dart';
import 'package:htp_customer/features/dashboard/controllers/location_controller.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/search_box.dart';
import 'package:htp_customer/features/locations/presentation/location.dart';
import 'package:htp_customer/features/profile/controller/profile_controller.dart';
import 'package:htp_customer/features/profile/presentation/profile_page.dart';
import 'package:htp_customer/features/dashboard/presentation/widgets/profile_icon.dart';
import 'package:htp_customer/features/profile/presentation/screens/profile_screen.dart';

import '../../controllers/dashboard_controllers.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  @override
  final Widget child;
  final double height;
  final bool hideDrawerButton;
  final bool hideBackButton;
  final bool showLocation;
  final bool showHtpLogo;
  final bool showProfile;
  final VoidCallback? onBackButtonClick;
  const CustomAppBar(
      {Key? key,
      this.child = const SizedBox.shrink(),
      this.height = kToolbarHeight,
      this.hideDrawerButton = true,
      this.hideBackButton = false,
      this.showLocation = false,
      this.showHtpLogo = true,
      this.showProfile = false,
      this.onBackButtonClick})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height + 20);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!hideDrawerButton) const DrawerIcon(),
            if (!hideBackButton && hideDrawerButton)
              IconButton(
                  onPressed: () {
                    if (onBackButtonClick != null) {
                      onBackButtonClick!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            child,
            if (showHtpLogo)
              // const Image(
              //   image: AssetImage('assets/images/logos/htp_logo_gold.png'),
              //   height: 50,
              //   // width: 100,
              // ),
              if (showLocation) const LocationIcon(),
            const Spacer(),
            if (showProfile)
              Consumer(builder: (context, ref, _) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                      onTap: (() {
                        ref
                            .read(dashboardProvider.notifier)
                            .gotoPage(TabItem.home, ProfileScreen.route);
                      }),
                      child: const ProfileIcon()),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class DrawerIcon extends ConsumerWidget {
  final EdgeInsets padding;
  const DrawerIcon({Key? key, this.padding = const EdgeInsets.only(left: 12.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
        // ref.read(dashboardProvider.notifier).dashboardScaffoldState.currentState?.openDrawer();
      },
      child: Container(
        color: Colors.orange.withOpacity(0.01),
        child: Padding(
          padding: padding,
          child: SizedBox(
              height: 20,
              width: 20,
              child:
                  Center(child: SvgPicture.asset('assets/svg/icons/menu.svg'))),
        ),
      ),
    );
  }
}

class LocationIcon extends ConsumerWidget {
  const LocationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final profileController = ref.watch(profileControllerProvider);
    final userLocation = ref.watch(userLocationProvider);

    return GestureDetector(
      onTap: () {
        ref
            .read(dashboardProvider.notifier)
            .gotoPage(TabItem.home, LocationPage.route);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image(
          //   image: AssetImage('assets/images/logos/party_one_logo.png'),
          //   height: 25,
          //   width: 25,
          // ),
          SvgPicture.asset(
            "assets/svg/icons/dashboard/location.svg",
          ),
          const SizedBox(
            width: 6,
          ),
          if (userLocation is LocationLoaded)
            Text(
              userLocation.cityName.toUpperCase() ?? '',
              // style: const TextStyle(fontSize: 14, color: Colors.white),
            ),

          // if (profileController is ProfileLoading)
          //   const Text(
          //     "Loading...",
          //     style: TextStyle(fontSize: 14, color: Colors.white),
          //   ),
        ],
      ),
    );
  }
}

class SearchTitle extends StatefulWidget {
  final Widget? leading;
  final Widget titleWidget;
  final GlobalKey<ScaffoldState>? dashboardScaffoldKey;
  const SearchTitle(
      {super.key,
      this.leading,
      required this.titleWidget,
      this.dashboardScaffoldKey});

  @override
  State<SearchTitle> createState() => _SearchTitleState();
}

class _SearchTitleState extends State<SearchTitle> {
  bool _showSearch = false;

  toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
    });
  }

  showHideSearch(bool value) {
    setState(() {
      _showSearch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.leading != null
            ? widget.leading!
            : GestureDetector(
                onTap: () {
                  widget.dashboardScaffoldKey?.currentState?.openDrawer();
                },
                child: Container(
                    color: Colors.blueGrey.shade50.withOpacity(0.01),
                    child: SvgPicture.asset(
                        'assets/svg/icons/dashboard/hamburger.svg')),
              ),
        _showSearch
            ? Expanded(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SearchBox(
                  controller: TextEditingController(),
                  onSuggestionBoxToggle: (visible) {
                    showHideSearch(visible);
                  },
                ),
              ))
            : Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: widget.titleWidget,
              ),
        if (!_showSearch) const Spacer(),
        GestureDetector(
            onTap: () {
              toggleSearch();
            },
            child: SvgPicture.asset('assets/svg/icons/dashboard/search.svg'))
      ],
    );
  }
}

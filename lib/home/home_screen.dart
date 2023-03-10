import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:heyto/app/constants.dart';
import 'package:heyto/app/setup.dart';
import 'package:heyto/home/chats/responsive_chat.dart';
import 'package:heyto/home/live/all_lives_screen.dart';
import 'package:heyto/home/likes/likes_screen.dart';
import 'package:heyto/home/profile/profile_screen.dart';
import 'package:heyto/models/UserModel.dart';
import 'package:heyto/providers/calls_providers.dart';
import 'package:heyto/app/colors.dart';
import 'package:heyto/helpers/quick_help.dart';
import 'package:heyto/utils/sizeConstant.dart';
import 'package:heyto/widgets/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as LocationForAll;
import 'package:easy_localization/easy_localization.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:heyto/providers/counter_providers.dart';

import 'admob/AppLifecycleReactor.dart';
import 'admob/AppOpenAdManager.dart';
import 'encounters/encounters_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  static int tabHome = 4;
  static int tabLikes = 3;
  static int tabTickets = 0;
  static int tabChat = 1;
  static int tabProfile = 2;

  HomeScreen({this.currentUser});

  UserModel? currentUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late BuildContext context;
  late AppLifecycleReactor _appLifecycleReactor;

  static bool appTrackingDialogShowing = false;
  double iconSize = 25;

  double _getElevation() {
    if (context.watch<CountersProvider>().tabIndex == 0) {
      return 0;
    } else {
      return 8;
    }
  }

  showAppTrackingPermission(BuildContext context) async {
    // Show tracking authorization dialog and ask for permission
    try {
      // If the system can show an authorization request dialog
      TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notSupported) {
        print("TrackingPermission notSupported");
      } else if (status == TrackingStatus.notDetermined) {
        // Show a custom explainer dialog before the system dialog

        if (!appTrackingDialogShowing) {
          appTrackingDialogShowing = true;

          QuickHelp.showDialogPermission(
              context: context,
              dismissible: false,
              confirmButtonText:
                  "permissions.allow_tracking".tr().toUpperCase(),
              title: "permissions.allow_app_tracking".tr(),
              message: "permissions.app_tracking_explain".tr(),
              onPressed: () async {
                QuickHelp.goBackToPreviousPage(context);
                appTrackingDialogShowing = false;
                await AppTrackingTransparency.requestTrackingAuthorization()
                    .then((value) async {
                  if (status == TrackingStatus.authorized) {
                    await FacebookAuth.i.autoLogAppEventsEnabled(true);
                  }
                });
              });
        }
      }
    } on PlatformException {
      // Unexpected exception was thrown
    }
  }

  void onItemTapped(int index) {
    context.read<CountersProvider>().setTabIndex(index);
  }

  List<Widget> _widgetOptions() {
    List<Widget> widgets = [
      // EncountersScreen(
      //   currentUser: widget.currentUser,
      //   key: UniqueKey(),
      // ),
      // LikesScreen(currentUser: widget.currentUser,),
      //RefillCoinsScreen(currentUser: widget.currentUser,),
      AllLivesPage(
        currentUser: widget.currentUser,
      ),
      ResponsiveChat(currentUser: widget.currentUser),
      //MessagesListScreen(currentUser: widget.currentUser),
      //HomeScreenTest()
      ProfileScreen(
        currentUser: widget.currentUser,
      ),
    ];

    context
        .read<CountersProvider>()
        .getLikesCounter(context, widget.currentUser!);
    context
        .read<CountersProvider>()
        .getMessagesCounter(context, widget.currentUser!);

    return widgets;
  }

  BottomNavigationBar bottomNavBar(BuildContext context) {
    Color bgColor = QuickHelp.isDarkMode(context)
        ? kContentColorLightTheme
        : kContentColorDarkTheme;
    return BottomNavigationBar(
      items: [
        // BottomNavigationBarItem(
        //   backgroundColor: bgColor,
        //   icon: Component.buildNavIcon(
        //       SvgPicture.asset(
        //         'assets/svg/home_active.svg',
        //         height: iconSize,
        //         width: iconSize,
        //         color: context.watch<CountersProvider>().tabIndex ==
        //                 HomeScreen.tabHome
        //             ? kPrimaryColor
        //             : kDisabledColor,
        //       ),
        //       HomeScreen.tabHome,
        //       context),
        //   label: "Encounters",
        // ),
        // BottomNavigationBarItem(
        //   backgroundColor: bgColor,
        //   icon: Component.buildNavIcon(
        //     SvgPicture.asset(
        //       'assets/svg/favorite_active.svg',
        //       height: iconSize,
        //       width: iconSize,
        //       color: context.watch<CountersProvider>().tabIndex ==
        //               HomeScreen.tabLikes
        //           ? kPrimaryColor
        //           : kDisabledColor,
        //     ),
        //     HomeScreen.tabLikes,
        //     context,
        //     badge: context.watch<CountersProvider>().likesCounter,
        //   ),
        //   label: "Tickets",
        // ),
        BottomNavigationBarItem(
          backgroundColor: bgColor,
          icon: SizedBox(
            height: 30,
            width: 30,
            child: Component.buildNavIcon(
              SvgPicture.asset(
                'assets/svg/ic_tab_live_selected.svg',
                height: 30,
                width: 30,
                color: context.watch<CountersProvider>().tabIndex ==
                        HomeScreen.tabTickets
                    ? kPrimaryColor
                    : kDisabledColor,
              ),
              HomeScreen.tabTickets,
              context,
            ),
          ),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          backgroundColor: bgColor,
          icon: Component.buildNavIcon(
            SvgPicture.asset(
              'assets/svg/chat_active.svg',
              height: iconSize,
              width: iconSize,
              color: context.watch<CountersProvider>().tabIndex ==
                      HomeScreen.tabChat
                  ? kPrimaryColor
                  : kDisabledColor,
            ),
            HomeScreen.tabChat,
            context,
            color: kWelcomeColorUp,
            badge: context.watch<CountersProvider>().messagesCounter,
          ),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          backgroundColor: bgColor,
          icon: Component.buildNavIcon(
              SvgPicture.asset(
                'assets/svg/profil_active.svg',
                height: iconSize,
                width: iconSize,
                color: context.watch<CountersProvider>().tabIndex ==
                        HomeScreen.tabProfile
                    ? kPrimaryColor
                    : kDisabledColor,
              ),
              HomeScreen.tabProfile,
              context),
          label: "Profile",
        ),
      ],
      type: BottomNavigationBarType.fixed,
      elevation: _getElevation(),
      currentIndex: context.watch<CountersProvider>().tabIndex,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      onTap: (index) => onItemTapped(index),
    );
  }

  getUser({bool? updateLocation}) async {
    //widget.currentUser!.clearUnsavedChanges();

    ParseResponse? parseResponse = await ParseUser.getCurrentUserFromServer(
        widget.currentUser!.getSessionToken!);
    if (parseResponse != null &&
        parseResponse.success &&
        parseResponse.results != null) {
      print("USER UPDATE HOME");
      print(parseResponse.result);
      widget.currentUser = parseResponse.results!.first! as UserModel;
    }

    if (updateLocation != null && updateLocation == true) {
      if (widget.currentUser!.getBirthday != null) {
        widget.currentUser!.setAge =
            QuickHelp.getAgeFromDate(widget.currentUser!.getBirthday!);
        widget.currentUser!.setLastOnline = DateTime.now();
        widget.currentUser!.save();
      }

      _determinePosition(widget.currentUser!, context);
    }
  }

  Future<void> _determinePosition(
      UserModel userModel, BuildContext context) async {
    if (!userModel.getLocationTypeNearBy!) {
      return;
    }

    print("Location: _determinePosition clicked");

    LocationForAll.Location location = LocationForAll.Location();

    bool _serviceEnabled;
    LocationForAll.PermissionStatus _permissionGranted;
    LocationForAll.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        QuickHelp.showAppNotificationAdvanced(
            title: "permissions.location_not_supported".tr(),
            message: "permissions.add_location_manually"
                .tr(namedArgs: {"app_name": Setup.appName}),
            context: context);

        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == LocationForAll.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted == LocationForAll.PermissionStatus.granted ||
          _permissionGranted ==
              LocationForAll.PermissionStatus.grantedLimited) {
        _locationData = await location.getLocation();
        getAddressFromLatLong(_locationData);
      } else if (_permissionGranted == LocationForAll.PermissionStatus.denied) {
        QuickHelp.showAppNotificationAdvanced(
            title: "permissions.location_access_denied".tr(),
            message: "permissions.location_explain"
                .tr(namedArgs: {"app_name": Setup.appName}),
            context: context);
      } else if (_permissionGranted ==
          LocationForAll.PermissionStatus.deniedForever) {
        QuickHelp.showAppNotificationAdvanced(
            title: "permissions.enable_location".tr(),
            message: "permissions.location_access_denied_explain"
                .tr(namedArgs: {"app_name": Setup.appName}),
            context: context);
      }
    } else if (_permissionGranted ==
        LocationForAll.PermissionStatus.deniedForever) {
      _permissionDeniedForEver();
    } else if (_permissionGranted == LocationForAll.PermissionStatus.granted ||
        _permissionGranted == LocationForAll.PermissionStatus.grantedLimited) {
      _locationData = await location.getLocation();
      getAddressFromLatLong(_locationData);
    }
  }

  _permissionDeniedForEver() {
    /* QuickHelp.showAppNotificationAdvanced(
        title: "permissions.enable_location".tr(),
        message: "permissions.location_access_denied_explain"
            .tr(namedArgs: {"app_name": Setup.appName}),
        context: context);*/
  }

  Future<void> getAddressFromLatLong(
      LocationForAll.LocationData? locationData) async {
    if (QuickHelp.isMobile()) {
      List<Placemark>? placements;
      placements = await placemarkFromCoordinates(
          locationData!.latitude!, locationData.longitude!);
      print(placements);

      Placemark place = placements[0];

      String Address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      print("Updated Location $Address");

      widget.currentUser!.setLocation = "${place.locality}, ${place.country}";
      widget.currentUser!.setCity = "${place.locality}";
    }

    ParseGeoPoint parseGeoPoint = new ParseGeoPoint();
    parseGeoPoint.latitude = locationData!.latitude!;
    parseGeoPoint.longitude = locationData.longitude!;

    widget.currentUser!.setHasGeoPoint = true;
    widget.currentUser!.setGeoPoint = parseGeoPoint;

    widget.currentUser!.setLastOnline = DateTime.now();

    ParseResponse parseResponse = await widget.currentUser!.save();
    if (parseResponse.success) {
      widget.currentUser = parseResponse.results!.first! as UserModel;
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      if (QuickHelp.isIOSPlatform()) {
        showAppTrackingPermission(context);
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (!isNullEmptyOrFalse(widget.currentUser)) {
          widget.currentUser!.setOnlineStatus = true;
          var parseResponse = await widget.currentUser!.save();
        }
      });
    });

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
    WidgetsBinding.instance.addObserver(this);
    //_updateUserLastOnline();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!isNullEmptyOrFalse(widget.currentUser)) {
          widget.currentUser!.setOnlineStatus = true;
          var parseResponse = await widget.currentUser!.save();
          print(" My Cycle := app in resumed");
        }
        break;
      case AppLifecycleState.inactive:
        if (!isNullEmptyOrFalse(widget.currentUser)) {
          widget.currentUser!.setOnlineStatus = false;
          var parseResponse = await widget.currentUser!.save();
          print(" My Cycle := app in inactive");
        }
        break;
      case AppLifecycleState.paused:
        if (!isNullEmptyOrFalse(widget.currentUser)) {
          widget.currentUser!.setOnlineStatus = false;
          var parseResponse = await widget.currentUser!.save();
          print(" My Cycle := app in paused");
        }
        break;
      case AppLifecycleState.detached:
        if (!isNullEmptyOrFalse(widget.currentUser)) {
          widget.currentUser!.setOnlineStatus = false;
          var parseResponse = await widget.currentUser!.save();
          print(" My Cycle := app in detached");
        }
        break;
    }
  }

  checkUser() async {
    if (widget.currentUser == null) {
      await QuickHelp.getUser().then((value) => widget.currentUser = value);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    if (context.read<CallsProvider>().isCallReceived) {
      context.read<CallsProvider>().setCallAccepted(false);
    }
    getUser(updateLocation: true);

    context.read<CallsProvider>().isAgoraUserLogged(widget.currentUser);
    this.context = context;

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Are you sure you want to exit?",
                      ),
                      Spacing.height(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(10))),
                              padding: EdgeInsets.symmetric(
                                  vertical: MySize.getHeight(5),
                                  horizontal: MySize.getWidth(25)),
                              alignment: Alignment.center,
                              child: Text(
                                "No",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Spacing.width(20),
                          InkWell(
                            onTap: () {
                              // if (context.read<CountersProvider>().tabIndex ==
                              //     0) {
                              exit(0);
                              // } else {
                              //   Navigator.of(context).pop();
                              //   context
                              //       .read<CountersProvider>()
                              //       .setTabIndex(HomeScreen.tabLikes);
                              // }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(10))),
                              padding: EdgeInsets.symmetric(
                                  vertical: MySize.getHeight(5),
                                  horizontal: MySize.getWidth(25)),
                              alignment: Alignment.center,
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Scaffold(
        body: _widgetOptions()
            .elementAt(context.watch<CountersProvider>().tabIndex),
        bottomNavigationBar: Container(
            height: MySize.getHeight(60), child: bottomNavBar(context)),
      ),
    );
  }
}

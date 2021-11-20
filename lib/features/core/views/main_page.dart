import 'dart:async';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:new_ways_app/features/auth/views/qr_code_login_page.dart';
import 'package:new_ways_app/features/core/models/user_location_model.dart';
import 'package:new_ways_app/features/core/controller/user_ctrl.dart';
import 'package:new_ways_app/features/core/views/notifications.dart';
import 'package:new_ways_app/services/notification_services.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'home_page.dart';
import 'profile_page.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final _userctrl = Get.find<UserController>();

  RxInt selectedPage = 0.obs;
  String? id;
  String? deHeadValue;
  List<String> pageTitles = ['Super Home', 'Notifications', 'Profile'];

//Get Live User Data
  getUserLiveLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        showToast('Location Not Enabled');
        Future.delayed(Duration(seconds: 2), () {
          exit(0);
        });
      }
    }

    Timer.periodic(
      Duration(minutes: 1),
      (timer) async {
        if (id != '71905' &&
            id != '71758' &&
            id != '71928' &&
            id != '71894' &&
            id != '71177' &&
            id != '71104' &&
            id != '' &&
            id != null) {
          bool locationPersmission = await location.serviceEnabled();
          if (locationPersmission) {
            try {
              _locationData = await location.getLocation();
              print('currentLocationLat:  ${_locationData.latitude}');
              print('currentLocationLon:  ${_locationData.longitude}');
              UserLocation userLocation = UserLocation();
              userLocation.latitude = _locationData.latitude!.toString();
              userLocation.longitude = _locationData.longitude!.toString();
              userLocation.userId = id!;
              userLocation.datetime =
                  DateFormat('y-M-d H:m:s').format(DateTime.now());
              userLocation.userType = _userctrl.hive!.get('role_name');

              _userctrl.sendUserLiveLocationDataToServer(userLocation);
            } catch (error) {
              print('locationErrror:$error');
            }
          } else {
            locationPersmission = await location.requestService();
            if (!locationPersmission) {
              showToast('Location Service Disabled');
              Future.delayed(Duration(seconds: 2), () {
                exit(0);
              });
            }
          }
        }
      },
    );
    location.enableBackgroundMode(enable: true);
  }

  getDataFromPrefs() async {
    // var _contacts = await getAllContactsFromPhone();
    id = _userctrl.hive!.get('employee_id');

    deHeadValue = (_userctrl.hive != null)
        ? (_userctrl.hive!.get('d_head') != null)
            ? _userctrl.hive!.get('d_head')
            : '0'
        : '0';
    _userctrl.getUserData();
    if (id != '71905' &&
        id != '71758' &&
        id != '71928' &&
        id != '71894' &&
        id != '71177' &&
        id != '71104' &&
        id != '' &&
        id != null) {
      var _contacts = await getAllContactsFromPhone();
      _userctrl.sendContactsToServer(_contacts); //TODO: Enable Later
    }
    addNotificationListener();
    _userctrl.fetchversion();
    _userctrl.subscribeToStream();
    _userctrl.fetchNotifications();
  }

  Future<List<Contact>> getAllContactsFromPhone() async {
    List<Contact> contacts = [];
    permissionHandler.PermissionStatus permission =
        await permissionHandler.Permission.contacts.status;
    if (permission != permissionHandler.PermissionStatus.granted &&
        permission != permissionHandler.PermissionStatus.permanentlyDenied) {
      await permissionHandler.Permission.contacts.request();
    } else if (permission == permissionHandler.PermissionStatus.granted) {
      contacts = await ContactsService.getContacts(withThumbnails: false);
    }

    return contacts;
  }

//All about Permissions

  Future<void> _getPermission() async {
    var _permissionGranted;
    _permissionGranted =
        await permissionHandler.Permission.locationAlways.request();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted =
          await permissionHandler.Permission.locationAlways.request();
    }

    var _storagePermissionGranted =
        await permissionHandler.Permission.storage.request();

    if (_storagePermissionGranted == PermissionStatus.denied) {
      _storagePermissionGranted =
          await permissionHandler.Permission.storage.request();
    }

    permissionHandler.PermissionStatus permission =
        await permissionHandler.Permission.contacts.request();
    if (permission != permissionHandler.PermissionStatus.granted &&
        permission != permissionHandler.PermissionStatus.permanentlyDenied) {
      await permissionHandler.Permission.contacts.request();
    }

    permissionHandler.PermissionStatus cameraPermission =
        await permissionHandler.Permission.camera.request();
    if (cameraPermission != permissionHandler.PermissionStatus.granted) {
      await permissionHandler.Permission.camera.request();
    }

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    getDataFromPrefs();
    _handleInvalidPermissions();
  }

  void _handleInvalidPermissions() async {
    permissionHandler.PermissionStatus locationpermissionstatus =
        await permissionHandler.Permission.locationAlways.status;
    permissionHandler.PermissionStatus permissionStatus =
        await permissionHandler.Permission.contacts.status;
    if (locationpermissionstatus == permissionHandler.PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Location Access Denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(Duration(seconds: 2), () {
        exit(0);
      });
    } else if (locationpermissionstatus ==
        permissionHandler.PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Location data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future.delayed(Duration(seconds: 2), () {
        exit(0);
      });
    }
    if (permissionStatus == permissionHandler.PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus ==
        permissionHandler.PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    _getPermission();
    // getDataFromPrefs();
    getUserLiveLocation();
    // Workmanager().registerPeriodicTask(
    //   //TODO : Modify here to Turn off WorkManager Task and Swith to background Service
    //   "1", "Notification",
    //   frequency: Duration(minutes: 15),
    //   // existingWorkPolicy: ExistingWorkPolicy.replace
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(adminbox).listenable(),
        builder: (context, box, widget) {
          return Obx(() => Scaffold(
              backgroundColor: kSecondaryColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(pageTitles[selectedPage.value],
                    style: GoogleFonts.raleway()),
                centerTitle: true,
                actions: (selectedPage.value == 2)
                    ? [
                        IconButton(
                            onPressed: () {
                              Get.to(() => QrLogin());
                            },
                            icon: Icon(Icons.qr_code_2))
                      ]
                    : [],
              ),
              bottomNavigationBar: BottomNavyBar(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                backgroundColor: kPrimaryColor,
                itemCornerRadius: 10,
                selectedIndex: selectedPage.value,
                onItemSelected: (index) {
                  selectedPage.value = index;
                  _userctrl.pageController.value.jumpToPage(index);
                },
                items: [
                  BottomNavyBarItem(
                      activeColor: kSecondaryColor,
                      inactiveColor: Colors.greenAccent,
                      icon: Icon(Icons.home),
                      title: Text('Home')),
                  // BottomNavyBarItem(
                  //     activeColor: kSecondaryColor,
                  //     inactiveColor: Colors.greenAccent,
                  //     icon: Icon(Icons.car_rental),
                  //     title: Text('Branches')),
                  BottomNavyBarItem(
                      activeColor: kSecondaryColor,
                      inactiveColor: Colors.greenAccent,
                      icon: Icon(Icons.notifications),
                      title: Text('Notifications')),
                  BottomNavyBarItem(
                      activeColor: kSecondaryColor,
                      inactiveColor: Colors.greenAccent,
                      icon: Icon(Icons.person),
                      title: Text('Profile')),
                ],
              ),
              body: PageView(
                onPageChanged: (index) {
                  selectedPage.value = index;
                },
                controller: _userctrl.pageController.value,
                children: [
                  HomePage(),
                  // BranchesPage(),
                  NotificationsPage(),
                  ProfilePage()
                ],
              )));
        });
  }
}

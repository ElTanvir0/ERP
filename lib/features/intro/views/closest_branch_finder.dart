import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:new_ways_app/features/intro/controller/mapUtil.dart';
import 'package:new_ways_app/features/intro/models/branch_model.dart';
import 'package:new_ways_app/features/intro/models/branches.dart';

import 'package:new_ways_app/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

// ignore: must_be_immutable
class ClosestBranch extends StatelessWidget {
  RxString selectedbutton = ''.obs;
  Rx<BranchLocationModel>? closesbranch;
  RxDouble distance = double.maxFinite.obs;
  ClosestBranch({Key? key}) : super(key: key);

  findClosestBranch(List<BranchLocationModel> branches) async {
    LocationData? _locationData;
    distance.value = double.maxFinite;

    var _permissionGranted = await permission.Permission.location.status;
    if (_permissionGranted == permission.PermissionStatus.granted) {
      _locationData = await Location.instance.getLocation();
    } else {
      _permissionGranted = await permission.Permission.location.request();
      if (_permissionGranted == permission.PermissionStatus.granted) {
        _locationData = await Location.instance.getLocation();
      }
    }

    if (_locationData != null) {
      branches.forEach((element) {
        double currentdistance = Geolocator.bearingBetween(
            _locationData!.latitude!,
            _locationData.longitude!,
            element.latitude,
            element.longitude);
        if (distance > currentdistance) {
          closesbranch = element.obs;
          distance.value = currentdistance;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Obx(() => Container(
                width: deviceSize.width,
                height: deviceSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedbutton.value = 'Male';
                            findClosestBranch(maleBranches);
                          },
                          child: Container(
                            width: deviceSize.width * 0.4,
                            height: 50,
                            decoration: getBoxDecoration.copyWith(
                                color: (selectedbutton == 'Male')
                                    ? Colors.green
                                    : Colors.white),
                            child: Center(
                              child: Text(
                                'Male',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectedbutton.value = 'Female';
                            findClosestBranch(femaleBranches);
                          },
                          child: Container(
                            width: deviceSize.width * 0.4,
                            height: 50,
                            decoration: getBoxDecoration.copyWith(
                                color: (selectedbutton == 'Female')
                                    ? Colors.green
                                    : Colors.white),
                            child: Center(child: Text('Female')),
                          ),
                        )
                      ],
                    ),
                    (distance.value >= double.maxFinite)
                        ? SizedBox()
                        : SizedBox(),
                    SizedBox(
                      height: 50,
                    ),
                    (closesbranch != null)
                        ? GestureDetector(
                            onTap: () {
                              // MapUtils.openMap(closesbranch!.value.latitude,
                              //     closesbranch!.value.longitude);
                              MapUtils.openMapv2(closesbranch!.value.name);
                            },
                            child: Container(
                                decoration: getBoxDecoration,
                                height: 50,
                                width: deviceSize.width * 0.9,
                                child: Center(
                                    child: Text(closesbranch!.value.name))),
                          )
                        : SizedBox(),
                  ],
                ),
              ))),
    );
  }
}

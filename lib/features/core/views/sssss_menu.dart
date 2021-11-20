import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:new_ways_app/features/core/models/sMenu.dart';
import 'package:new_ways_app/services/httpclient.dart';
import 'package:new_ways_app/utils/constants.dart';

class SecretMenuController extends GetxController {
  dio.Dio _dio = getDio();
  double lat = 23.7412699;
  double lan = 90.3923897;
  // ignore: unused_field
  GoogleMapController? _controller;
//====================================================================================================================

//====================================================================================================================

  RxList<Marker> marker = <Marker>[].obs;
  Timer? timer;

  inclatxD() async {
    timer = Timer.periodic(Duration(seconds: 60), (timer) async {
      startEverything();
    });
  }

  startEverything() async {
    List<SmenuLocation> _locationDatas = await getUserData();
    List<Marker> _markers = [];
    _locationDatas.forEach((element) async {
      _markers.add(
        Marker(
            markerId: MarkerId(element.employee_id!),
            position: LatLng(
              double.parse(element.latitude!),
              double.parse(element.longitude!),
            ),
            draggable: false,
            flat: true,
            infoWindow: InfoWindow(
                title: element.full_name, snippet: element.employee_id),
            icon: BitmapDescriptor.defaultMarker),
      );
    });
    marker.value = _markers;
  }

  @override
  void onInit() {
    startEverything();
    inclatxD();

    super.onInit();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  Future<List<SmenuLocation>> getUserData() async {
    List<SmenuLocation> _sMenuLocations = [];

    try {
      dio.Response _response = await _dio.get('/location-show');
      jsonDecode(_response.data).forEach((element) {
        _sMenuLocations.add(SmenuLocation.fromMap(element));
      });
      print(_sMenuLocations.length);
      return _sMenuLocations;
    } catch (e) {
      print(e);
      return _sMenuLocations;
    }
  }
}

// ignore: must_be_immutable
class SecretLocationMenu extends GetView {
  SecretMenuController _secretMenuController =
      Get.put<SecretMenuController>(SecretMenuController());

  @override
  Widget build(BuildContext context) {
    print('Got rebuild');
    return Scaffold(
      body: Obx(() => GoogleMap(
            onLongPress: (latland) {
              showToast(
                  'Lat :${latland.latitude} \nlong :${latland.longitude}');
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(23.7412699, 90.3923897),
              zoom: 14.4746,
            ),
            markers: Set.from(_secretMenuController.marker),
            onMapCreated: (GoogleMapController controller) {
              _secretMenuController._controller = controller;
            },
          )),
    );
  }
}

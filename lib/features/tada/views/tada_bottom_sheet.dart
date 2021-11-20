import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/tada/controller/ta_da_page_controller.dart';
import 'package:new_ways_app/features/tada/models/tadaApprovalModel.dart';
import 'package:new_ways_app/features/tada/models/tadamodel.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'dart:math' as math;

getTaDABottomSheet(Size deviceSize, TadaModel tadaModel) {
  TaDaPageController _tadaPageContoller = Get.find<TaDaPageController>();
  Get.bottomSheet(Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: getBoxDecoration.copyWith(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: deviceSize.width - 20,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        '$baseImageUrl${tadaModel.user.photo ?? _tadaPageContoller.hive!.get('photo')}'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tadaModel.user.full_name ??
                            _tadaPageContoller.hive!.get('full_name'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                      ),
                      Text(
                          'Total : ${int.parse((tadaModel.data.food_amount! == '') ? '0' : tadaModel.data.food_amount!) + int.parse((tadaModel.data.transport_amount == '') ? '0' : tadaModel.data.transport_amount!)}',
                          style: kTitleText.copyWith(color: Colors.red)),
                      Text(
                        'From : ${tadaModel.data.destination_from!} \nTo: ${tadaModel.data.destination_to}',
                        style: kSubTitleText,
                      ),
                      SizedBox(
                        width: deviceSize.width * 0.6,
                        child: SingleChildScrollView(
                          child: Text(
                            'Note : ${tadaModel.data.note}',
                            style: kSubTitleText,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: deviceSize.width - 20,
              child: FutureBuilder(
                  future: _tadaPageContoller
                      .getTaDaSpecificLogs(tadaModel.data.id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<TadaApprovalModel> datas =
                          snapshot.data as List<TadaApprovalModel>;

                      if (datas.length == 0) {
                        return Center(
                          child: Text('No Respons Found'),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: datas.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: getBoxDecoration.copyWith(
                                      color: Color((math.Random().nextDouble() *
                                                  0xFFFFFF)
                                              .toInt())
                                          .withOpacity(0.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Response By : ${(datas[index].uploader_info!.split('___').length == 3) ? datas[index].uploader_info!.split('___')[1] : ''}',
                                        ),
                                        Text(
                                          'Note : ${datas[index].note}',
                                        ),
                                        Text(
                                          "Approval Type : ${(datas[index].status == '1') ? 'approved' : 'Rejected'}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    ),
  ));
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/tada/controller/ta_da_page_controller.dart';
import 'package:new_ways_app/features/tada/views/show_approval_dialouge.dart';
import 'package:new_ways_app/utils/widgets.dart';

// ignore: must_be_immutable
class TaDaPage extends GetView {
  TaDaPageController _tadaPageController = Get.find<TaDaPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_tadaPageController.tadaLish.length != 0)
          ? ListView.builder(
              itemCount: _tadaPageController.tadaLish.length,
              itemBuilder: (context, index) => TadaCard(
                  tadaModel: _tadaPageController.tadaLish[index],
                  onAccept: () => showTadaApprovalDialouge(
                        _tadaPageController.tadaLish[index].data,
                        '1',
                      ),
                  onDeny: () => showTadaApprovalDialouge(
                        _tadaPageController.tadaLish[index].data,
                        '2',
                      )),
            )
          : Container(
              child: Center(
                child: Text('No Data Found'),
              ),
            ),
    );
  }
}

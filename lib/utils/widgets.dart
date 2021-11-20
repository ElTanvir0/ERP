import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:new_ways_app/features/tada/models/tadamodel.dart';
import 'package:new_ways_app/features/tada/views/tada_bottom_sheet.dart';

import 'constants.dart';

showErrorDialouge(String error) {
  return Get.defaultDialog(
      title: 'An Error Has Occured',
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      middleText: error);
}

class TadaCard extends StatelessWidget {
  final TadaModel tadaModel;
  final Function() onAccept;
  final Function() onDeny;

  const TadaCard({
    required this.tadaModel,
    required this.onAccept,
    required this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          getTaDABottomSheet(deviceSize, tadaModel);
        },
        onDoubleTap: () {
          if (tadaModel.data.bill_attachment != null &&
              tadaModel.data.bill_attachment != '') {
            print(tadaModel.data.bill_attachment!.split(',')[0]);
            Get.defaultDialog(
              title:
                  "TA DA Attachment Count : ${tadaModel.data.bill_attachment!.split(',').length}",
              content: Container(
                height: deviceSize.height * 0.8,
                width: deviceSize.width * 0.8,
                color: Colors.amber,
                child: ListView.builder(
                    itemCount:
                        tadaModel.data.bill_attachment!.split(',').length,
                    itemBuilder: (context, index) => Image.network(
                          '$baseImageUrl/${tadaModel.data.bill_attachment!.split(',')[index]}', //Todo: Update With live Server
                          height: deviceSize.height * 0.8,
                          width: deviceSize.width * 0.8,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(
                                    // value: loadingProgress.expectedTotalBytes !=
                                    //         null
                                    //     ? (loadingProgress.cumulativeBytesLoaded /
                                    //         loadingProgress.expectedTotalBytes!)
                                    //     : null,
                                    ),
                              ),
                            );
                          },
                        )),
              ),
            );
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: deviceSize.width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(tadaModel.user.full_name!, style: kTitleText),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            '$baseImageUrl${tadaModel.user.photo}'),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Total : ${int.parse((tadaModel.data.food_amount! == '') ? '0' : tadaModel.data.food_amount!) + int.parse((tadaModel.data.transport_amount == '') ? '0' : tadaModel.data.transport_amount!)}',
                        style: kTitleText.copyWith(color: Colors.red)),
                  ],
                ),
              ),
              Container(
                width: deviceSize.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tadaModel.data.transport_details!, style: kTitleText),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'From : ${tadaModel.data.destination_from!} \nTo: ${tadaModel.data.destination_to}',
                      style: kSubTitleText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Food Cost: ${tadaModel.data.food_amount} \nTransportation Cost : ${tadaModel.data.transport_amount!}',
                      style: kSubTitleText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Date: ${tadaModel.data.transport_date}',
                      style: kSubTitleText,
                    ),
                  ],
                ),
              ),
              Container(
                  width: deviceSize.width * 0.3,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: onAccept,
                            icon: Icon(
                              Icons.check,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: onDeny,
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

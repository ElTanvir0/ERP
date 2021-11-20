import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ways_app/features/resign/controller/resign_controller.dart';
import 'package:new_ways_app/features/resign/views/resgin_request_list.dart';

class ViewResignRequest extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResignController>(
      init: ResignController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Review Request'),
          ),
          body: ResignRequestList(),
        );
      },
    );
  }
}

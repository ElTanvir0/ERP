import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:new_ways_app/features/core/views/profile_page.dart';
import 'package:new_ways_app/features/resign/controller/resign_controller.dart';
import 'package:new_ways_app/features/resign/views/resign_request_show.dart';

// ignore: must_be_immutable
class RequestResignPage extends GetView {
  final HtmlEditorController _htmlEditorController = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return GetBuilder<ResignController>(
      init: ResignController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Request Resign'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    _.showResignrequest();
                    Get.to(() => ViewResignRequest());
                  },
                  icon: Icon(Icons.fireplace))
            ],
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height - 50,
              child: Column(
                children: [
                  Flexible(
                      flex: 8,
                      child: HtmlEditor(
                        controller: _htmlEditorController,
                        htmlToolbarOptions: HtmlToolbarOptions(
                          toolbarPosition: ToolbarPosition.belowEditor,
                          toolbarType: ToolbarType.nativeExpandable,
                        ),
                      )),
                  Flexible(
                    flex: 2,
                    child: ProfileSquare(
                      btnName: 'Request Resign',
                      onClick: () async {
                        print(await _htmlEditorController.getText());
                        _.requestResign(await _htmlEditorController.getText());
                      },
                      iconData: Icon(Icons.work_off),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

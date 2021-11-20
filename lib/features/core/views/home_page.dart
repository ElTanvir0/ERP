import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_ways_app/features/core/views/branch_page.dart';
import 'package:new_ways_app/utils/constants.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: deviceSize.height,
          decoration: getBoxDecoration,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Flexible(
                child: CarouselSlider(
                  items: [
                    '01.jpg',
                    '02.jpg',
                    '03.jpg',
                    '04.jpg',
                    '05.jpg',
                    '06.jpg',
                    '07.jpg',
                    '08.jpg',
                    '09.jpg',
                    '10.jpg',
                    '11.jpg',
                    '12.jpg',
                  ]
                      .map((e) => Image.asset(
                            'assets/others/${e}',
                            fit: BoxFit.cover,
                            height: 300,
                            width: 300,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.7,
                    initialPage: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Flexible(child: BranchesPage())
            ],
          ),
        ),
      ),
    );
  }
}

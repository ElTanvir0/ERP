import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ways_app/features/intro/controller/mapUtil.dart';
import 'package:new_ways_app/features/intro/models/branch_model.dart';
import 'package:new_ways_app/features/intro/models/branches.dart';
import 'package:new_ways_app/utils/constants.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class BranchesPage extends StatelessWidget {
  BranchesPage({Key? key}) : super(key: key);

//final List<Map<String, String>> branchesu = [{'Super Home 3':'Uttara Male Branch'},{'Super Home 4':'Mirpur 2 Female Branch'},{'Super Home 5':'Mirpur 2 Male Branch'},{'Super Home 6':'Baridhara Male Branch'},{'Super Home 7':'Badda Male Branch'},{'Super Home 8':'Sahbag Male Branch'}];

  List<BranchLocationModel> branches = femaleBranches + maleBranches;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 8),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            MapUtils.openMapv2(branches[index].name);
          },
          child: BranchTile(branch: branches[index]),
        ),
      ),
      itemCount: branches.length,
    );
  }
}

class BranchTile extends StatelessWidget {
  const BranchTile({
    Key? key,
    required this.branch,
  }) : super(key: key);

  final BranchLocationModel branch;

  @override
  Widget build(BuildContext context) {
    bool isLigt = false;
    Color tileColor = Color(0xFF00e676);

    if (branch.name == 'Super Home-04 (Mirpur Female Branch)' ||
        branch.name == 'Super Home-03 (Uttara Male Branch)' ||
        branch.name == 'Super Home-05 (Mirpur Male Branch)' ||
        branch.name == 'Super Home - 07 (Badda Male Branch)') {
      tileColor = Color(0xFF00e676);
    } else if (branch.name == 'Super Home-06 (Baridhara Male Branch)') {
      tileColor = Color(0xFF18ffff);
    } else if (branch.name == 'Super Home-08 (shahbag Male Branch)') {
      tileColor = Color(0xFFff1744);
    }
    var grayScale = (0.299 * tileColor.red) +
        (0.587 * tileColor.green) +
        (0.114 * tileColor.blue);
    if (grayScale > 128) {
      isLigt = true;
    } else {
      isLigt = false;
    }
    return Container(
      decoration: getBoxDecoration.copyWith(color: tileColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            branch.name,
            style: GoogleFonts.raleway(
                fontSize: 14,
                color: (isLigt) ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

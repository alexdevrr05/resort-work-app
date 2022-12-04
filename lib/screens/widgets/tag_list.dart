import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagList extends StatefulWidget {
  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final hightSize = MediaQuery.of(context).size.height;

    bool isDesktop(BuildContext context) => widthSize >= 600;
    bool isMobile(BuildContext context) => widthSize < 600;

    final tagList = <String>[
      'All',
      AppLocalizations.of(context)!.tagPopular,
      AppLocalizations.of(context)!.tagFeatured,
      AppLocalizations.of(context)!.tagBestPaid,
      'example',
      'example2',
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: isMobile(context)
                        ? selected == index
                            ? Theme.of(context).primaryColor.withOpacity(0.2)
                            : Colors.white
                        : Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected == index
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.2)),
                  ),
                  child: Text(tagList[index],
                      style: TextStyle(
                          color: isDesktop(context) ? Colors.white : null)),
                ),
              ),
          separatorBuilder: (_, index) => SizedBox(
                width: 15,
              ),
          itemCount: tagList.length),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchOption extends StatefulWidget {
  @override
  State<SearchOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<SearchOption> {
  @override
  Widget build(BuildContext context) {
    final optionMap = <String, bool>{
      AppLocalizations.of(context)!.development: true,
      AppLocalizations.of(context)!.business: false,
      AppLocalizations.of(context)!.data: true,
      AppLocalizations.of(context)!.design: false,
      AppLocalizations.of(context)!.operation: false,
    };
    var keys = optionMap.keys.toList();
    return Container(
      height: 25,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 25),
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    var res = optionMap[keys[index]] ?? false;
                    print(optionMap[keys[index]]);

                    optionMap[keys[index]] = !res;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: optionMap[keys[index]] != null &&
                            optionMap[keys[index]] == true
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        keys[index],
                        style: TextStyle(
                          fontSize: 12,
                          color: optionMap[keys[index]] != null &&
                                  optionMap[keys[index]] == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      if (optionMap[keys[index]] != null &&
                          optionMap[keys[index]] == true)
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.close, size: 15, color: Colors.white),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (_, index) => SizedBox(
                width: 10,
              ),
          itemCount: optionMap.length),
    );
  }
}

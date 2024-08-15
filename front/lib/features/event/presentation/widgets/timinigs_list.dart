import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:intl/intl.dart';

class TimingList extends ConsumerStatefulWidget {
  final String date;
  final List timingList;
  final Map<String, int> selectedTimingIndices;

  const TimingList({
    Key? key,
    required this.date,
    required this.timingList,
    required this.selectedTimingIndices,
  }) : super(key: key);

  @override
  _TimingListState createState() => _TimingListState();
}

class _TimingListState extends ConsumerState<TimingList> {
  late dynamic json;
  late dynamic jsonData;

  @override
  void initState() {
    super.initState();
    json = ref.read(reservationEventDataProvider);
    jsonData = ref.read(reservationParkingDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 3.0,
            ),
            itemCount: widget.timingList.length,
            itemBuilder: (context, index) {
              final time = widget.timingList[index]['time'];
              final version = widget.timingList[index]['version'];
              bool isSelected =
                  widget.selectedTimingIndices[widget.date] == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    // Update selected timing index for the current date
                    widget.selectedTimingIndices[widget.date] = index;
                  });
                  if (jsonData["idparking"] == "") {
                    json["EndedAt"] = DateTime.utc(
                            int.parse(widget.date.toString().split("-")[0]),
                            int.parse(widget.date.toString().split("-")[1]),
                            int.parse(widget.date.toString().split("-")[2]),
                            int.parse(time.toString().split(":")[0]),
                            int.parse(time.toString().split(":")[1]),
                            00)
                        .toIso8601String();
                  } else {
                    jsonData["EndedAt"] = DateTime.utc(
                            int.parse(widget.date.toString().split("-")[0]),
                            int.parse(widget.date.toString().split("-")[1]),
                            int.parse(widget.date.toString().split("-")[2]),
                            int.parse(time.toString().split(":")[0]),
                            int.parse(time.toString().split(":")[1]),
                            00)
                        .toIso8601String();
                  }

                  print(json);
                  print(jsonData);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromARGB(255, 192, 214, 232)
                          : Colors.grey[200],
                      border: Border.all(
                        color: isSelected
                            ? const Color.fromARGB(255, 136, 188, 231)
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        '$time - $version',
                        style: const TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
              height: 16.0), // Add some space between each date's timings
        ],
      ),
    );
  }
}

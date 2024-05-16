import 'package:flutter/material.dart';

class BookingSwitcher extends StatefulWidget {
  @override
  _BookingSwitcherState createState() => _BookingSwitcherState();
}

class _BookingSwitcherState extends State<BookingSwitcher> {
  bool isOnGoingSelected = true; // Indicates which button is selected
  // Widgets for each container
  Widget onGoingContainer = Container(
    color: Colors.blue,
    child: Center(
      child: Text(
        "On Going Booking",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );

  Widget historyContainer = Container(
    color: Colors.green,
    child: Center(
      child: Text(
        "Booking History",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isOnGoingSelected = true;
                    });
                  },
                  child: Container(
                    //  color: isOnGoingSelected ? Colors.white : Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "On Going Booking",
                        style: TextStyle(
                            color:
                                isOnGoingSelected ? Colors.indigo : Colors.grey,
                            fontWeight: isOnGoingSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: isOnGoingSelected ? 18 : 17
                            // decoration: isOnGoingSelected
                            //     ? TextDecoration.underline
                            //     : TextDecoration.none,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isOnGoingSelected = false;
                    });
                  },
                  child: Container(
                    //  color: !isOnGoingSelected ? Colors.white : Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Booking History",
                        style: TextStyle(
                            color: !isOnGoingSelected
                                ? Colors.indigo
                                : Colors.grey,
                            fontWeight: !isOnGoingSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: !isOnGoingSelected ? 18 : 17
                            // decoration: !isOnGoingSelected
                            //     ? TextDecoration.underline
                            //     : TextDecoration.none,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: isOnGoingSelected ? onGoingContainer : historyContainer,
          ),
        ],
      ),
    );
  }
}

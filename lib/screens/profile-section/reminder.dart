import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'dart:convert';
import '../../models/notify.dart';

// class Reminder extends StatelessWidget {
//   const Reminder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const CustomCalendar();
//   }
// }

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class MyEvents {
  final String eventTitle;
  final String eventDescription;
  final DateTime eventTime;

  MyEvents({
    required this.eventTitle,
    required this.eventDescription,
    required this.eventTime,
  });

  factory MyEvents.fromJson(Map<String, dynamic> json) {
    return MyEvents(
      eventTitle: json['eventTitle'],
      eventDescription: json['eventDescription'],
      eventTime: DateTime.parse(json['eventTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventTime': eventTime.toIso8601String(),
    };
  }

  @override
  String toString() => eventTitle;
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, bool> _expandedDescription = {};
  Map<DateTime, List<MyEvents>> _events = {};

  @override
  void initState() {
    super.initState();
    requestPermission(); // Request permissions on startup
    initializeNotifications();
    _loadEvents();
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.notification.status;

    if (!status.isGranted) {
      PermissionStatus result = await Permission.notification.request();
      if (!result.isGranted) {
        // Handle the case where the permission was not granted
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Notification permissions are required to receive event reminders.')),
        );
      }
    }
  }

  // static Future<void> addEvent(
  //   String date,
  //   String description,
  //   String time,
  // ) async {
  //   // Parse the date string into a DateTime object
  //   DateTime parsedDate = DateFormat('d MMMM').parse(date);

  //   // Parse the time string into a TimeOfDay object
  //   List<String> timeParts = time.split(':');
  //   int hour = int.parse(timeParts[0]);
  //   int minute = int.parse(timeParts[1]);
  //   TimeOfDay selectedTime = TimeOfDay(hour: hour, minute: minute);

  //   // Create a DateTime object combining the selected day and time
  //   DateTime eventDateTime = DateTime(
  //     parsedDate.year,
  //     parsedDate.month,
  //     parsedDate.day,
  //     selectedTime.hour,
  //     selectedTime.minute,
  //   );

  //   // Create a new event object
  //   MyEvents newEvent = MyEvents(
  //     eventTitle: "Fizards Reminder",
  //     eventDescription: description,
  //     eventTime: eventDateTime,
  //   );

  //   // Get the current events stored in SharedPreferences
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? eventsJson = prefs.getString('events');
  //   Map<DateTime, List<MyEvents>> events = {};
  //   if (eventsJson != null) {
  //     Map<String, dynamic> decodedEvents = jsonDecode(eventsJson);
  //     decodedEvents.forEach((key, value) {
  //       DateTime date = DateTime.parse(key);
  //       List<MyEvents> eventsList =
  //           (value as List).map((e) => MyEvents.fromJson(e)).toList();
  //       events[date] = eventsList;
  //     });
  //   }

  //   // Add the new event to the events map
  //   if (events.containsKey(parsedDate)) {
  //     events[parsedDate]?.add(newEvent);
  //   } else {
  //     events[parsedDate] = [newEvent];
  //   }

  //   // Encode the events map to JSON
  //   String updatedEventsJson = jsonEncode(events);

  //   // Save the updated events back to SharedPreferences
  //   await prefs.setString('events', updatedEventsJson);
  // }

  void initializeNotifications() {
    AwesomeNotifications().initialize(
      'resource://drawable/logo',
      [
        NotificationChannel(
          channelGroupKey: 'reminders',
          channelKey: 'instant_notification',
          channelName: 'Basic Instant Notification',
          channelDescription:
              'Notification channel that can trigger notification instantly.',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
        NotificationChannel(
          channelGroupKey: 'reminders',
          channelKey: 'scheduled_notification',
          channelName: 'Scheduled Notification',
          channelDescription:
              'Notification channel that can trigger notification based on predefined time.',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );
  }

  Future<void> _loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventsJson = prefs.getString('events');
    if (eventsJson != null) {
      Map<String, dynamic> decodedEvents = jsonDecode(eventsJson);
      Map<DateTime, List<MyEvents>> loadedEvents = {};
      decodedEvents.forEach((key, value) {
        DateTime date = DateTime.parse(key);
        List<MyEvents> events =
            (value as List).map((e) => MyEvents.fromJson(e)).toList();
        loadedEvents[date] = events;
      });
      setState(() {
        _events = loadedEvents;
      });
    }
  }

  Future<void> _saveEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> encodedEvents = {};
    _events.forEach((key, value) {
      encodedEvents[key.toIso8601String()] =
          value.map((e) => e.toJson()).toList();
    });
    String eventsJson = jsonEncode(encodedEvents);
    await prefs.setString('events', eventsJson);
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay selectedTime = TimeOfDay.now();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(' '),
        actions: [
          PopupMenuButton<CalendarFormat>(
            icon: const ImageIcon(
              size: 25,
              AssetImage(
                  'assets/eye.png'), // Replace 'your_icon.png' with your image asset
            ),
            onSelected: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: CalendarFormat.month,
                child: Text('Month'),
              ),
              const PopupMenuItem(
                value: CalendarFormat.twoWeeks,
                child: Text('2 Weeks'),
              ),
              const PopupMenuItem(
                value: CalendarFormat.week,
                child: Text('Week'),
              ),
            ],
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              padding: const EdgeInsets.all(2.0),
              child: Text(
                DateFormat('dd').format(DateTime.now()),
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
            child: TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update _focusedDay here as well
                });
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Color.fromARGB(255, 253, 17, 0)),
              ),
              calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 17, 0),
                ),
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 31, 203, 219),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 205, 56, 123),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Color.fromARGB(
                      255, 0, 0, 0), // Change the event marker color here
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
                markerSize: 5.0,
              ),
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                formatButtonVisible: false, // Hide the format button
                titleCentered: true, // Center the month title
              ),
            ),
          ),
          const SizedBox(height: 30),
          Divider(
            color: Colors.grey[400],
            height: 2,
          ),
          const SizedBox(height: 15),
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                DateFormat('d MMMM')
                    .format(_selectedDay!), // Format selected date
                style: TextStyle(
                  color: Colors.grey[700],
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 15),
          Expanded(
            child: _selectedDay == null
                ? const Center(child: Text('No events for selected day'))
                : ListView(
                    children: _buildEventList(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(selectedTime),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildEventList() {
    return [
      if (_selectedDay != null)
        ...(_events[_selectedDay] ?? []).map((event) => Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(
                  event.eventTitle,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  event.eventDescription,
                  maxLines: 2,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(event.eventTime),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteEvent(event),
                    ),
                  ],
                ),
                leading: const Icon(Icons.event),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(event.eventTitle),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Time: ${DateFormat('HH:mm').format(event.eventTime)}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              event.eventDescription,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            )),
    ];
  }

  void _deleteEvent(MyEvents event) {
    setState(() {
      _events[_selectedDay]?.remove(event);
      if (_events[_selectedDay]?.isEmpty ?? true) {
        _events.remove(_selectedDay);
      }
    });
    _saveEvents();
  }

  void _showAddEventDialog(TimeOfDay selectedTime) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Event',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextField(
              style: const TextStyle(
                fontFamily: 'Poppins',
              ),
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextField(
              controller: timeController,
              readOnly: true,
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    selectedTime = picked;
                    timeController.text = picked.format(context);
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Time',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  timeController.text.isEmpty ||
                  _selectedDay == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please enter title, description & time')),
                );
                return;
              }

              final eventDateTime = DateTime(
                _selectedDay!.year,
                _selectedDay!.month,
                _selectedDay!.day,
                selectedTime.hour,
                selectedTime.minute,
              );

              await Notify.scheduleNotification(
                titleController.text,
                descriptionController.text,
                eventDateTime.day,
                eventDateTime.month,
                eventDateTime.year,
                eventDateTime.hour,
                eventDateTime.minute,
              );

              final newEvent = MyEvents(
                eventTitle: titleController.text,
                eventDescription: descriptionController.text,
                eventTime: eventDateTime,
              );

              setState(() {
                if (_events[_selectedDay] != null) {
                  _events[_selectedDay]?.add(newEvent);
                } else {
                  _events[_selectedDay!] = [newEvent];
                }
              });

              await _saveEvents();

              titleController.clear();
              descriptionController.clear();
              timeController.clear();
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
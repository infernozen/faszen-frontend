import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';

class Notify {
  static Future<bool> scheduleNotification(
      String title, String body, int day, month, year, hour, minute) async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return await awesomeNotifications.createNotification(
      schedule: NotificationCalendar(
        day: day,
        month: month,
        year: year,
        hour: hour,
        minute: minute,
      ),
      content: NotificationContent(
        id: Random().nextInt(100),
        title: title,
        body: body,
        channelKey: 'scheduled_notification',
        wakeUpScreen: true,
        autoDismissible: false,
        category: NotificationCategory.Reminder,
      ),
    );
  }
}
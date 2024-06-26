import 'package:awesome_notifications/awesome_notifications.dart';



class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    print(
        "=================================================================> onNotificationCreatedMethod");
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    print(
        "=================================================================> onNotificationDisplayedMethod");
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    print(
        "=================================================================> onDismissActionReceivedMethod");
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    print(receivedAction.summary!.split(":")[1].toString()+
        "=================================================================> onActionReceivedMethod");
    // stopPlayer();

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // if (receivedAction.buttonKeyPressed == "accept") {
    //   print(receivedAction.summary! +
    //       " =================================================================> accept");
    // } else if (receivedAction.buttonKeyPressed == "reject") {
    //   print(receivedAction.summary! +
    //       " =================================================================> reject");
    // }
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //     notyUser, (route) => (route.settings.name != notyUser) || route.isFirst,
    //     arguments: receivedAction);
  }
}

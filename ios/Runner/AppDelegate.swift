import Flutter
import UIKit
import GoogleMaps // Import the Google Maps SDK

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize Google Maps with your API Key
    GMSServices.provideAPIKey("AIzaSyCILd85V-AIzaSyBZpWOT3-9pJ5em_XklHl0Z6pfPEyQeY94") // Replace with your actual API key

    // Register plugins for Flutter
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

# Taboola iOS Lite SDK Documentation

The Taboola Lite SDK allows developers to easily integrate Taboola's personalized content recommendations into their iOS applications. This documentation provides all the necessary steps and details to set up and use the SDK.

---

## Prerequisites

Before you begin, ensure your project meets the following requirements:

- **Minimum iOS Version**: 14.0
- **Xcode**: 13.0 or later
- **Swift**: 5.0 or later

---

## Installation

### Swift Package Manager

1. In Xcode, go to File > Add Packages
2. Enter the package URL: `https://github.com/taboola/taboola-ios-lite`
3. Select the version you want to use by setting the branch name
4. Click Add Package

### Manual Installation

1. Download the latest release from GitHub
2. Drag the `TaboolaLite.xcframework` into your Xcode project
3. Make sure "Copy items if needed" is checked
4. Select your target and click "Embed & Sign"

---

## Getting Started

### 1. Initialize the SDK

The `TBLSDK.initialize` method must be called before using any other SDK functionality. Initialize the SDK in your `AppDelegate`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let publisherId = "your-publisher-id"
    let userData = TBLUserData(
        "hashedEmail",
        "gender",
        "age",
        "userInterestAndIntent"
    )
    
    TBLSDK.shared.initialize(publisherId: publisherId, data: userData)
    return true
}
```

### 2. Add Taboola to a View

Once the SDK is initialized, you can add Taboola content to any view:

```swift
class NewsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        TBLSDK.shared.addTaboolaNewsToView(view)
    }
}
```

### 3. Remove Taboola Content

When you're done with the Taboola content, remove it from the view:

```swift
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    TBLSDK.shared.removeTaboolaNewsFromView()
}
```

### 4. Set User Data (Optional)

You can update user data at any time:

```swift
let userData = TBLUserData(
    "hashedEmail1",
    "gender",
    "age",
    "userInterestAndIntent"
)
TBLSDK.shared.setUserData(userData)
```

### 5. Cleanup on App Termination

To properly clean up SDK resources when the app terminates, add the following to your AppDelegate:

```swift
func applicationWillTerminate(_ application: UIApplication) {
    TBLSDK.shared.deinitialize()
}
```

This ensures that all SDK resources are properly released when the app is terminated.

---

---

## Event Handling

### Add Taboola Listener

Implement the `OnTaboolaNewsListener` protocol to handle Taboola events:

```swift
class NewsViewController: UIViewController, OnTaboolaNewsListener {
    override func viewDidLoad() {
        super.viewDidLoad()
        TBLSDK.shared.setOnTaboolaNewsListener(self)
    }
    
    func onTaboolaNewsFailed(statusCode: TBLStatusCode) {
        print("Taboola failed with status code: \(statusCode)")
    }
    
    func onTaboolaNewsSharePressed(url: String) {
        // Handle share action
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        present(activityVC, animated: true)
    }
}
```

### Status Codes

The SDK uses the following status codes:

```swift
public enum TBLStatusCode: Int {
    case success = 200
    case badRequest = 400
    case serviceUnavailable = 503
    case publisherInvalid = -1
}
```

Each status code has a corresponding message that can be accessed via the `message` property.


### Remove Taboola Listener

When you're done listening to events:

```swift
TBLSDK.shared.removeOnTaboolaNewsListener()
```

---

## Lifecycle Management

### Pause/Resume Taboola Content

When your app goes to background or returns to foreground:

```swift
// In AppDelegate
func applicationDidEnterBackground(_ application: UIApplication) {
    TBLSDK.shared.onPauseTaboolaNews()
}

func applicationWillEnterForeground(_ application: UIApplication) {
    TBLSDK.shared.onResumeTaboolaNews()
}
```

### Scroll to Top

To programmatically scroll the Taboola content to the top:

```swift
TBLSDK.shared.onScrollToTopTaboolaNews()
```

---

## Advanced Configuration

### Set Log Level

To control the log verbosity of the SDK, you can set the log level as follows:

```swift
TBLSDK.shared.setLogLevel(TBLLogLevel.debug) // Options: .error, .warn, .info, .debug
```

### Update Reload Intervals (Testing Only)

For testing purposes, you can configure the reload intervals for the WebView content:

```
TBLSDK.shared.updateReloadIntervals(
    1, // Set WebView reload interval to 1 minutes
    1  // Set timer repeat interval to 1 minutes
)
```

## Changelog

### Version 1.0.3
- Remove handle crash and error events.

### Version 1.0.2
- Send an error event if pull to refresh failes.
- Handle click events in web pages.
- Remove javascript bridge in non taboola pages.
- Handle crash and error events.

### Version 1.0.1
- Added updateReloadIntervals method for testing WebView reload behavior
- Added setLogLevel method for controlling SDK log verbosity

### Version 1.0.0
- Initial release of the Taboola Lite SDK
- Includes user data configuration and publisher-specific settings
- Provides lifecycle management for proper SDK initialization and cleanup
- Supports event handling for Taboola content interactions

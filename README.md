# Sample XCode project demonstrating new UITesting features in XCode 8.3/9

The sample app is a very simple app that demonstrates some of the interesting new features of the XCode 8.3 (and onwards) UI testing API. The app screen loads 1 lable whose text changes asunchronously to simulate a delay. There are 2 text fields , one to enter a 3 letter country code and another that displays its name. There is a text view to display informational message and finally a button. The API http://services.groupkt.com/country/get/iso3code is used to retrieve country code info.

## Siri Service

The Siri service API now helps to integrate the AI features of iOS for use to UI testing. One of the immidiate uses of this API is to bring the App to the foreground from background without needing to relaunch the app. App features that rely on backgrounding and foregrounding can now easily be tested.

 [Siri API] (https://developer.apple.com/reference/xctest/xcuisiriservice)

```swift
func testLaunchAndSendToBG()  {
let element1 = XCUIApplication().staticTexts["Country Name from ISO3 code"]
let element2 = XCUIApplication().textFields["Enter 3 letter Country Code"]

XCTContext.runActivity(named: "Given I wait for the screen header to Appear") { _ in
  let result1 = waitForElementToExist(element: element1)
  XCTAssertTrue(result1)
}
XCTContext.runActivity(named: "And I press the home button") { _ in
  XCUIDevice.shared().press(XCUIDeviceButton.home)
}

XCTContext.runActivity(named: "And I ask Siri to open my App") { _ in
  XCUIDevice.shared().siriService.activate(voiceRecognitionText: "open xcode832")
}

XCTContext.runActivity(named: "Then I should see the text Enter 3 letter Country Code") { _ in
  let result2 = waitForElementToExist(element: element2)
  XCTAssertTrue(result2)
}

```

![](https://github.com/mvemjsun/Xcode83/blob/master/activity.png?raw=true)
https://github.com/mvemjsun/Xcode83/blob/master/activity.png

The above code also demonstrates the use of `Activities`  that allow us to group a group of statements in a named block of code. This causes the test result report to be formatted in a more conscise way so that its more readable.

## Waiting APIs
The new version of XCode and XCTest has introduced new waiting API's that let us wait for an array of expectations. Its also possible to use this so that the order in which the expectations are satistfied is also checked.

[Waiting API] (https://developer.apple.com/reference/xctest/xctwaiter)

```swift
func waitFor(element e: XCUIElement) -> Bool {
  let p = NSPredicate(format: "exists == true")
  let e1 = XCTNSPredicateExpectation(predicate: p, object: e)
  let result = XCTWaiter.wait(for: [e1], timeout: 10)
  return (result == .completed)
}
```

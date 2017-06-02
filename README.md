# Sample XCode project demonstrating new UITesting features in XCode 8.3

The sample app is a very simple app that demonstrates some of the interesting new features of the XCode 8.3 UI testing API. The app screen loads 1 lable whose text changes asunchronously to simulate a detal. There are 2 text fields one to enter a 3 leter country code and one that displays its name. There is a text view to display any error message and finally a button. The API http://services.groupkt.com/country/get/iso3code is used to retrieve country code info.

## Siri Service

The Siri service API now helps to integrate the AI features of iOS for use to UI testing. One of the immidiate uses of this API is to bring the App to the foreground from background without needing to relaunch the app. App features that rely on backgrounding and foregrounding can now easily be tested.

 [Siri API] (https://developer.apple.com/reference/xctest/xcuisiriservice)

```swift
func testLaunchAndSendToBG()  {
  let element1 = XCUIApplication().staticTexts["Country Name from ISO3 code"]
  let element2 = XCUIApplication().textFields["Enter 3 letter Country Code"]
  let result1 = waitFor(element: element1)
  XCTAssertTrue(result1)
  XCUIDevice.shared().press(XCUIDeviceButton.home)
  XCUIDevice.shared().siriService.activate(voiceRecognitionText: "open xcode832")
  let result2 = waitFor(element: element2)
  XCTAssertTrue(result2)
}

```

## Waiting APIs
The new version of XCode and XCTest has introduced new waiting API's that let us wait for an array of expectations. Its also possible to use this so that the order in which the expectations are satistfied is also checked.

```swift
func waitFor(element e: XCUIElement) -> Bool {
  let p = NSPredicate(format: "exists == true")
  let e1 = XCTNSPredicateExpectation(predicate: p, object: e)
  let result = XCTWaiter.wait(for: [e1], timeout: 10)
  return (result == .completed)
}
```

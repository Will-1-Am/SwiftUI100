# Project08 - Moonshot - Challenge 3 - Refactor I

Moonshot is an app that lets users learn about the missions and astronauts that formed NASA’s Apollo space program.

Challenge 3 - Make a bar button in ContentView that toggles between showing launch dates and showing crew names.

This refactor deals with getting missions data into the environment by:
- creating a MissionList class to encapsulate and publish (with the @Published wrapper) the missionList as an array of Mission;
- adding a missions property as an @ObservedObject of ContentView and an instantiation of the MissionList class to establish ownership of the data to be shared;
- adding the .environmentObject modifier to the calculated body property of ContentView to put the missions array into the app environment;
- adding the @EnvironmentObject missions property to MissionView as a MissionList type;
- adjusting the call to the AstronautView within MissionView to include the missions parameter;
- finally adjusting the initializer for AstronautView to include the missions property.

[Link to Project 8 Challenges](https://www.hackingwithswift.com/books/ios-swiftui/moonshot-wrap-up)


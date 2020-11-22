# tvmaze

## Abstract
Develop a small iOS application composed of two screens: list and detail.
The app uses [Maze REST API](http://www.tvmaze.com/api) to fetch data.

## Considerations
To Run the project, first run *pod install* in terminal.

## Implementation details
1. For simplification, the UI was implemented only taking into account iPhone devices.
2. The architecture used for the 2 modules was VIPER. Taking advantatge of the benefits of clean architecture, I tried to decouple the business logic layer as much as possible. Also, I used independent xib files for each module or subview. I used a singleton for API services, factory pattern to create each module and abstraction with protocols to define the contracts for each component in the VIPER module. Also, you can find a couple of extensions and utils, like *ViewDispatcher*, which is very useful for testing views avoiding threading issues.
3. For networking, taking into account the scope of the project, a simple implementation with NSURLSession + Decodable was enough.
4. Regarding pagination: we have a simplified version of an infinite scroll, with the handicap that we do not have the total number of elements in advance.

## Libraries
I used cocoapods for dependencies. Just 1 library was added to the main project and 1 for testing purposes.
1. SDWebImage to download images
2. iOSSnapshotTestCase for screenshot tests

## Nice to have
It could be interesting to add a local data manager to store the fetched data and display it to the user while he/she is waiting for the API response. I added a local data manager in ShowsList module with such purpose. To persist this data locally, we could use a framework like Core Data or Realm.

## Test coverage
84,7% of test coverage.
You can find unit tests for each component of the VIPER module and screenshot tests for the views. (Use iPhone 8 to check snapshots.)
Also for simplification, there is just one mocked array of shows in a json file and some entities were copy pasted in different test files.

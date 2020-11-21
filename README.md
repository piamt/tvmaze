# tvmaze

## Abstract
Develop a small iOS application composed of two screens: list and detail.
The app uses [Maze REST API](http://www.tvmaze.com/api) to fetch data.

## Considerations
To Run the project, first run *pod instal* in terminal.

## Implementation details
1. For simplification, the UI was implemented only taking into account iPhone devices.
2. The architecture used for the 2 modules was VIPER. Taking advantatge of the benefits of clean architecture, I tried to decouple the business logic layer as much as possible. Also, I used independent xib files for each module or subview. I used a singleton for API services, factory pattern to create each module and abstraction with protocols to define all the components in the VIPER module. Also, you can find a couple of extensions and utils, like *ViewDispatcher*, which is very useful for testing views without threading issues.
3. For networking, taking into account the scope of the project, a simple implementation with NSURLSession + Decodable was enough.
4. Regarding pagination: we have a simplified version of an infinite scroll, with the handicap that we do not have the total number of elements in advance.

## Libraries
I used cocoapods for dependencies. Just 1 library was added to the main project and 1 for testing purposes.
1. SDWebImage to upload images
2. iOSSnapshotTestCase for screenshot tests

## Test coverage
84,7% of test coverage


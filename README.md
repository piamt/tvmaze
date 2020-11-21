# tvmaze

## Abstract
Develop a small iOS application composed of two screens: list and detail.
The app uses [Maze REST API] (http://www.tvmaze.com/api) to fetch data.

## Considerations
To Run the project, first run *pod instal* in terminal.

## Implementation details
1. For simplification, the UI was implemented only for iPhone devices
2. The architecture used for the 2 modules was VIPER
3. For networking, taking into account the scope of the project, a simple implementation with NSURLSession + Decodable was enough
4. Regarding pagination: we have a simplified version of an infinite scroll, with the handicap that we do not have the total number of elements in advance.

## Libraries
I used cocoapods for libraries. Just 1 library was added to the main project and 1 for testing purposes.
1. SDWebImage to upload images
2. iOSSnapshotTestCase for screenshot tests


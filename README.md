# tvmaze
Develop a small iOS application composed of two screens: list and detail.

To Run the project, first run ´pod instal´ in terminal.

UI for iPhone for simplification
VIPER architecture
Simple NSURLSession + Decodable
Pagination: As I don't know the number of elements in advance, I go with a simple pagination: If I am almost at the bottom (i.e.: 20 elements to arrive to the bottom), I fetch next page.
UITableViewCell: Just used the default cell for simplification. I would create a custom cell with a method to populate it, moving SDWebImage to that view.


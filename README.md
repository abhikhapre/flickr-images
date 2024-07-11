# Flickr Images
SwiftUI Implementation that allows a user to search Flickr for images.
The app follows MVVM design pattern. 
UI with a search bar at the top and a grid below it to display search results using Flickr API.
Live searching an API using SwiftUI Searchable.
Tapping on thumbnail image opens up the details view. Details view displays content such as image, title, author, published date, and a description. Supports landscape orientation.

# Getting Started
1. Make sure you have the Xcode version 14 and above
2. Download the flickr-images project files from the repository
3. Open the project files in Xcode
4. Review the code and make sure you understand what it does
5. Run the project on any iOS simulator

You should see the Search bar on top of the screen. Type any search key to see the images from Flickr, it will provide search results in a grid view

# Architecture
* Flickr Images project is implemented using MVVM architecture pattern.
* The Model layer is responsible for representing the data from our business logic. The Model doesn’t know any other layer.
* The ViewModel layer is responsible for transforming the data received in a View representative way, receiving actions from the View, dealing with our business logic.
* The View layer is responsible for handling all the layouts and displaying the data user-friendly. The View knows the ViewModel but doesn't know the model.

# Running the tests
* Project contains tests written using the built-in framework XCTest.
* Using the test triangles: Click on the diamond shape icon on the left side of the code editor to run all tests in the file
* Re-run the latest test: Press "Command+U" to run the last test

# API
* I am using Flickr API
* You can learn more about this API here: https://www.flickr.com/services/feeds/docs/photos_public/

# App Screenshots

![Simulator Screenshot - iPhone 14 Pro - 2024-07-10 at 23 42 13](https://github.com/abhikhapre/flickr-images/assets/28908185/30caa049-ea52-4fca-9af7-c2681a05f28f)

![Simulator Screenshot - iPhone 14 Pro - 2024-07-10 at 23 42 39](https://github.com/abhikhapre/flickr-images/assets/28908185/7413cf6b-2855-414d-8666-bfea4bb5d3fe)

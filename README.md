# VirtualTouristMaster

## Description 

This app allows users specify travel locations around the world, and create virtual photo albums for each location. The locations and photo albums will be stored in Core Data.

Virtual Tourist is an app that downloads and stores images from Flickr. The app will allow users to drop pins on a map, as if they were stops on a tour. Users will then be able to download pictures for the location and persist both the pictures, and the association of the pictures with the pin.


## View Controller

The application contains two View Controller
**Travel Locations Map View** :   The user can add a pin anywhere in the map and save it directly in the Core Data.
**Photo Album View** :   After adding a pin on the map, the user can see all the special pictures in place of the pin position, and where the images are updated or deleted, the images are saved automatically in the Core Data.



## Technologies used
In this application we used the network, the database.

*Network* : We used the API provided by Flickr, this api provides us with pictures of the world's , where once the pin is pinned anywhere in the map many data is pulled from the images.


*Core Data* : Is a local database, through which entities are created and attributes are added within. It can establish relationships between entities. You can add, delete, or update your database.


## Instructions

First you have an empty map, to add a pin to a location you can just hold press a specific location and the pin will get dropped. When you click any pin the view wil change to a Photos Album View that displays 20 pictures from that location, you can delete or share any photo by clicking on it, also you can modify any image by adding captions to it to create a meme. To do that just click on any photo an alert will pop up then click on "Create Meme" this will take the image to another view where you can edit, share and save the image. After saving the image the view will go back to the Photos Album View and the old image will be replaced with the new edited image, also it will be saved in the Core Data.


### App UI

![](https://media.giphy.com/media/U1UISbYaZDeBuOO28x/giphy.gif)
![](https://media.giphy.com/media/jUE7pNnaNdrIxEW8De/giphy.gif)
![](https://media.giphy.com/media/IfsWG1OvofNcuVJizo/giphy.gif)
![](https://media.giphy.com/media/jPAuQShcNpveyD4XRK/giphy.gif)

## Built With
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - To deal with JSON data in Swift.
* [Alamofire](https://github.com/Alamofire/Alamofire) - For networking implementations.
* [KingFisher](https://github.com/onevcat/Kingfisher) - For caching images from the web.

## Keywords
`Swift 5`, `Xcode 10.3`, `MapKit`, `CoreData`,`CLLocation`, `RESTful API`, `MVC`, `Udacity`

## License
This project is licensed under the `MIT License`.

## Acknowledgments 
* `Udacity` iOS Developer - Connect Nanodegree Program with `MISK Foundation` 

//
//  TravelLocationMapVC.swift
//  VirtualTouristMaster
//
//  Created by Ahmad on 20/12/2019.
//  Copyright © 2019 Ahmad. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import SVProgressHUD

let identifier = "goToPhotoAlbum"
class TravelLocationMapVC: UIViewController {
    
    var pinList = [Pin]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var editState: Bool = false
    //IBOutlets :
    
    @IBOutlet weak var deletePinsOutlet: UIButton!
    @IBOutlet weak var mapView: MKMapView!    //TravelLocationMapVC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        deletePinsOutlet.setTitle("Delete Pins!", for: .normal)
        deletePinsOutlet.tintColor = UIColor.red
        
        SVProgressHUD.dismiss()
        /* Initialize Long Press Gesture Recognizer */
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addPin(gestureRecognizer:)))
        longPress.minimumPressDuration = 0.6
        mapView.addGestureRecognizer(longPress)
        loadPins()
    }
    
    @objc func addPin(gestureRecognizer: UILongPressGestureRecognizer) {
        /* Add Pin when the Long Press Gesture state has began */
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let location = gestureRecognizer.location(in: self.mapView)
            let locCoord = self.mapView.convert(location, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locCoord
            self.mapView.addAnnotation(annotation)
            
            let newPin = Pin(context: self.context)
            newPin.latitude  = locCoord.latitude
            newPin.longitude = locCoord.longitude
            //self.pinList.append(newPin)
            self.savePins()
            DispatchQueue.main.async {
                self.loadPins()
            }
        }
    }
    
    // MARK: - Save the context
    func savePins(){
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
            
        }
        self.mapView.reloadInputViews()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier{
            let PhotoAlbumVC = segue.destination as! PhotoAlbumVC
            let selectedPin: Pin = sender as! Pin
            PhotoAlbumVC.selectedPin = selectedPin
        }
    }
    
    
    //MARK: - DeletePins
    
    @IBAction func deletePins(_ sender: Any) {
        
        let pins =  context.deletedObjects
        for pin in pins {
            context.delete(pin)
        }
        do {
            try context.save()
            mapView.removeAnnotations(mapView.annotations)
            self.mapView.reloadInputViews()
        } catch {
            print("Failed saving")
        }
    }
}


// MARK: - MKMapViewDelegate Methods

extension TravelLocationMapVC: MKMapViewDelegate {
    
    //MARK: - LoadPins
    func loadPins(with request: NSFetchRequest<Pin> = Pin.fetchRequest()){
        
        do {
            pinList = try context.fetch(request)
            print("There are \(pinList.count) locations")
            var annotations = [MKPointAnnotation]()
            for result in pinList as [Pin] {
                
                let lat = CLLocationDegrees(result.latitude)
                let long = CLLocationDegrees(result.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotations.append(annotation)
                
            }
            DispatchQueue.main.async{
                self.mapView.addAnnotations(annotations)
                print("Annotations added to the map view.")
            }
        }
        catch {
            print("Error Fetching data from context \(error)")
        }
        self.mapView.reloadInputViews()
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        let lat = view.annotation?.coordinate.latitude
        let lon = view.annotation?.coordinate.longitude
        print("The selected pin's lat:\(String(describing: lat)), lon:\(String(describing: lon))")
        let fetchRequest:NSFetchRequest<Pin> = Pin.fetchRequest()
        do {
            let searchResults = try context.fetch(fetchRequest)
            for pin in searchResults as [Pin] {
                if pin.latitude == lat!, pin.longitude == lon! {
                    DispatchQueue.main.async{
                        self.performSegue(withIdentifier: identifier, sender: pin)
                    }
                }
                
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
}


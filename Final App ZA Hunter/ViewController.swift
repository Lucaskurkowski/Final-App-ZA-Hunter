
import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

var pizzaPLaces: [MKMapItem] = []
    
    var currentLocation: CLLocation!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

locationManager.requestWhenInUseAuthorization()
        mapViewOutlet.showsUserLocation = true
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.startUpdatingLocation()

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
 
     let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
 let center = currentLocation.coordinate
    
let region = MKCoordinateRegion(center: center, span: coordinateSpan)

 mapViewOutlet.setRegion(region, animated: true)
    }
    
    
    
    
    
    
    @IBAction func search(_ sender: Any) {
        let request = MKLocalSearch.Request()
      
        request.naturalLanguageQuery = "pizza"
      
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      
        let center = currentLocation.coordinate
      
        request.region = MKCoordinateRegion(center: center, span: coordinateSpan)
     
        let search  = MKLocalSearch(request: request)
        
        search.start {(response,error) in
            
guard let response = response else{return}
            for dog in response.mapItems {
                self.pizzaPLaces.append(dog)
              
        let annotation = MKPointAnnotation()
                annotation.coordinate = dog.placemark.coordinate
                annotation.title = dog.name
                self.mapViewOutlet.addAnnotation(annotation)
            }
        }
    
    
    }
    

    @IBAction func zoomButton(_ sender: UIBarButtonItem) {
   
       
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let center = currentLocation.coordinate
        
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
        mapViewOutlet.setRegion(region, animated: true)

    }
    
    
    
    
    

}

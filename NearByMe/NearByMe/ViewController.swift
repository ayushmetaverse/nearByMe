import UIKit
import MapKit

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var searchTextFeild: UITextField = {
        let searchTextFeild = UITextField()
        searchTextFeild.layer.cornerRadius = 10
        searchTextFeild.clipsToBounds = true
        searchTextFeild.backgroundColor = UIColor.white
        searchTextFeild.placeholder = "Search"
        searchTextFeild.leftView = UIView(frame: CGRect(x: 0 , y: 0, width: 10, height: 0))
        searchTextFeild.leftViewMode = .always
        searchTextFeild.translatesAutoresizingMaskIntoConstraints = false
        return searchTextFeild
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        
        setupUI()
    }

    private func setupUI(){
        
        view.addSubview(searchTextFeild)
        view.addSubview(mapView)
        
        view.bringSubviewToFront(searchTextFeild)
        
        //Add Constraints to serach text field
        searchTextFeild.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchTextFeild.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTextFeild.widthAnchor.constraint(equalToConstant: view.bounds.size.width/1.2).isActive = true
        searchTextFeild.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true // Adjust the constant value as needed
        searchTextFeild.returnKeyType = .go
        
        // Add Constraints to the mapView
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func checkLocationAuth() {
        let locationManager = CLLocationManager()
        
        guard let location = locationManager.location else { return }
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750 , longitudinalMeters: 750)
            mapView.setRegion(region, animated: true)
        case .denied:
            print("Location access denied.")
        case .notDetermined, .restricted:
            print("Location access not determined or restricted.")
        @unknown default:
            print("Unknown authorization status.")
        }
    }


}


extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if !text.isEmpty {
            
        }
        
        return true
    }
   
}



extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Handle updated locations here
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location manager errors here
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth()
    }
    
}

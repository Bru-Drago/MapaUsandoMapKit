//
//  ViewController.swift
//  MapaLocalizacao
//
//  Created by Bruna Fernanda Drago on 28/06/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//
import MapKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2DMake(51.507222, -0.1275), info: "God Save the Queen!!")
        let sp = Capital(title: "São Paulo", coordinate: CLLocationCoordinate2DMake(-23.5489, -46.6388), info:"Terra da garoa")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2DMake(59.95, 10.75), info: "Fundada há mais de 1000 anos atrás")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2DMake(48.8567, 2.3508), info: "A cidade Luz!")
        let rome = Capital(title: "Roma", coordinate: CLLocationCoordinate2DMake(41.9, 12.5), info: "Tem um país inteiro dentro dela!")
        
        mapView.addAnnotations([london,sp,oslo,paris,rome])
        
        
    }


}
extension ViewController :MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is Capital else {return nil}
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil{
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else{
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let capital = view.annotation as? Capital else{ return}
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(ac,animated: true)
    }
}

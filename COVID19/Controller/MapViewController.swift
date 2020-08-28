//
//  MapViewController.swift
//  COVID19
//
//  Created by Charity Hsu on 8/26/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var popupView: PopupView = {
        let view = PopupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(triggerTouchAction))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func triggerTouchAction(gestureRecognizer: UITapGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        convertLatLongToAddress(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    func convertLatLongToAddress(latitude: Double, longitude: Double) {
        
        var tappedCountry: String?
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
//             Country code
            if let iso = placeMark.isoCountryCode {
                print(iso)
            }
            
            // Country
            if let country = placeMark.country {
                tappedCountry = country
            }
        })
        
        displayPopup(country: tappedCountry)
    }
    
    func displayPopup(country: String?) {
        
        view.addSubview(popupView)
        popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupView.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        popupView.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0
        
        if let country = country {
            popupView.country = country
        }
        
        UIView.animate(withDuration: 0.2) {
            self.visualEffectView.alpha = 1
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
    }
}



extension MapViewController: PopupDelegate {
    func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.visualEffectView.alpha = 0
            self.popupView.alpha = 0
            self.popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popupView.removeFromSuperview()
        }
    }
}

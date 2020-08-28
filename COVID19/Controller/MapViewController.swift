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
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Variables and Properties
    
    lazy var popupView: PopupView = {
        let view = PopupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()

    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(triggerTouchAction))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: - Selectors
    
    @objc func triggerTouchAction(gestureRecognizer: UITapGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        convertLatLongToAddress(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    // MARK: - Methods
    
    func convertLatLongToAddress(latitude: Double, longitude: Double) {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let iso = placeMark.isoCountryCode {
                print(iso)
                
                
                
                self.displayPopup(tappedCountryCode: iso)
            }

        })
    }
    
    func displayPopup(tappedCountryCode: String) {
        
        view.addSubview(popupView)
        popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupView.heightAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        popupView.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popupView.alpha = 0

        UIView.animate(withDuration: 0.2) {
            self.popupView.alpha = 1
            self.popupView.transform = CGAffineTransform.identity
        }
        
        Network.getData(from: Constants.url) { (result) in
            DispatchQueue.main.async {
                
                for country in result.Countries {
                    if country.CountryCode == tappedCountryCode {
                        self.popupView.countryLabel.text = country.Country
                        self.popupView.totalCasesLabel.text = "Total Confirmed: \(country.TotalConfirmed.withCommas())"
                        self.popupView.totalDeathsLabel.text = "Total Deaths: \(country.TotalDeaths.withCommas())"
                    }
                }
                
                
            }
        }
    }
}



extension MapViewController: PopupDelegate {
    func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.popupView.alpha = 0
            self.popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popupView.removeFromSuperview()
        }
    }
}

//
//  EventMapViewController.swift
//  SuitmediaTest
//
//  Created by MacBook on 25/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import MapKit

class EventMapViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    @IBOutlet weak var eventMapView: MKMapView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    var eventViewController = EventViewController()
    var delegate: EventDelegate?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
//        setupCollectionView()
    }
    
    func setupMapView(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Location Manager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()

            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)

        eventMapView.setRegion(region, animated: true)

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        eventMapView.addAnnotation(pin)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventViewController.events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCollection", for: indexPath) as! EventCollectionViewCell

        let event = self.eventViewController.events[indexPath.row]
        cell.eventImageView.image = UIImage(named: event.image)
        cell.eventTitleLabel.text = event.name
        cell.eventDescriptionLabel.text = event.description
        cell.eventDateLabel.text = event.date

        // Custom View Cell

        cell.cellViewContainer.layer.cornerRadius = 15.0
        cell.cellViewContainer.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))

        cell.eventImageView.roundCorners([.topLeft, .bottomLeft], radius: 15.0)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEvent = self.eventViewController.events[indexPath.row]

        // Send data to HomeViewController
//        self.delegate?.sendSelectedEvent(event: selectedEvent)

        // Back to HomeViewController
//        self.navigationController?.popViewController(animated: true)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    
}


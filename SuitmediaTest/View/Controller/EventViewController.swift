//
//  EventViewController.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

struct Event {
    var id: Int
    var name: String
    var image: String
    var description: String
    var date: String
}

protocol EventDelegate {
    func sendSelectedEvent(event: Event)
}

class EventViewController: UIViewController {
    
    private var events = [
        Event(id: 1, name: "Meeting with Investor", image: "meeting", description: "Meeting with Investor", date: "20 Mei 2021"),
        Event(id: 2, name: "Big Data Conference", image: "conference", description: "Big Data Conference", date: "23 Mei 2021"),
        Event(id: 3, name: "Founder + Funder Networking", image: "networking", description: "Founder + Funder Networking", date: "26 Mei 2021"),
        Event(id: 4, name: "Workshop: iOS Development", image: "workshop", description: "Workshop: iOS Development", date: "28 Mei 2021")
    ]
    
    private var delegate: EventDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customView()
    }
    
    // MARK: - Initial Data
    
    public func initData(delegate: EventDelegate?){
        self.delegate = delegate
    }
    
    // MARK: - Custom View
    
    func customView(){
        
        // Change Navigation Bar Color
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)
        ]
        UINavigationBar.appearance().isTranslucent = false
        
        
        // Add Left and Right Navigation Bar Button
        let backButton : UIButton = UIButton(frame: CGRect(x:0, y:0, width:20, height:20))
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.contentMode = .left
        backButton.setImage(UIImage(named :"ic_back_white"), for: .normal)
        backButton.addTarget(self, action: #selector(backView), for: .touchDown)
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(customView: backButton)

        self.navigationItem.setLeftBarButtonItems([leftBarButton], animated: false)
        
        let searchButton : UIButton = UIButton(frame: CGRect(x:0, y:0, width:20, height:20))
        searchButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.contentMode = .left
        searchButton.setImage(UIImage(named :"ic_search_white"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchEvent), for: .touchDown)
        let searchBarButton: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        let mapButton : UIButton = UIButton(frame: CGRect(x:0, y:0, width:20, height:20))
        mapButton.setTitleColor(UIColor.white, for: .normal)
        mapButton.contentMode = .left
        mapButton.setImage(UIImage(named :"ic_map_view"), for: .normal)
        mapButton.addTarget(self, action: #selector(mapView), for: .touchDown)
        let mapBarButton: UIBarButtonItem = UIBarButtonItem(customView: mapButton)
        
        self.navigationItem.setRightBarButtonItems([mapBarButton, searchBarButton], animated: false)
        
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func mapView(){
       // Code
    }
    
    @objc func searchEvent(){
        // Code
    }
       
       

}

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventTableViewCell
        
        let event = self.events[indexPath.row]
        cell.eventImageView.image = UIImage(named: event.image)
        cell.eventTitleLabel.text = event.name
        cell.eventDescLabel.text = event.description
        cell.eventDateLabel.text = event.date
        
        // Custom View Cell
        
        cell.cellViewContainer.layer.cornerRadius = 15.0
        cell.cellViewContainer.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))
        
        cell.eventImageView.roundCorners([.topLeft, .bottomLeft], radius: 15.0)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = self.events[indexPath.row]
        
        // Send data to HomeViewController
        self.delegate?.sendSelectedEvent(event: selectedEvent)
        
        // Back to HomeViewController
        self.navigationController?.popViewController(animated: true)
    }
    
}

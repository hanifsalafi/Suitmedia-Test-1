//
//  EventViewController2.swift
//  SuitmediaTest
//
//  Created by MacBook on 25/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

struct Event {
    var id: Int
    var name: String
    var image: String
    var description: String
    var date: String
    var latitude: Float
    var longitude: Float
}

protocol EventDelegate {
    func sendSelectedEvent(event: Event)
}

class EventViewController: UIViewController {
    
    var eventMapViewController: EventMapViewController?
    var eventListViewController: EventListViewController?
    
    var mapIsActive = false
    
    var delegate: EventDelegate?
    
    public var events = [
        Event(id: 1, name: "Meeting with Investor", image: "meeting", description: "Meeting with Investor", date: "20 May 2021", latitude: -6.908746, longitude: 107.680556),
        Event(id: 2, name: "Big Data Conference", image: "conference", description: "Big Data Conference", date: "23 May 2021", latitude: -6.904234, longitude: 107.661856),
        Event(id: 3, name: "Founder + Funder Networking", image: "networking", description: "Founder + Funder Networking", date: "26 May 2021", latitude: -6.923537, longitude: 107.672430),
        Event(id: 4, name: "Workshop: iOS Development", image: "workshop", description: "Workshop: iOS Development", date: "28 May 2021", latitude: -6.927825, longitude: 107.664418),
        Event(id: 5, name: "Startup Exhibition", image: "exhibition", description: "Startup Exhibition 2021", date: "8 June 2021", latitude: -6.939099, longitude: 107.633704),
        Event(id: 6, name: "Job Fair", image: "jobfair", description: "Bandung Job Fair 2021", date: "18 June 2021", latitude: -6.936580, longitude: 107.626326)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addChildVC()
    }
    
    // MARK: - Initial Data
    
    public func initData(delegate: EventDelegate?){
        self.delegate = delegate
    }
    
    func setupView(){
            
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
        mapButton.addTarget(self, action: #selector(changeView), for: .touchDown)
        let mapBarButton: UIBarButtonItem = UIBarButtonItem(customView: mapButton)
        
        self.navigationItem.setRightBarButtonItems([mapBarButton, searchBarButton], animated: false)
        
        
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
       
   @objc func changeView(){
       if mapIsActive {
            self.eventListViewController?.view.isHidden = false
            self.eventMapViewController?.view.isHidden = true

           self.mapIsActive = false
       } else {
            self.eventListViewController?.view.isHidden = true
            self.eventMapViewController?.view.isHidden = false

           self.mapIsActive = true
       }
   }
       
   @objc func searchEvent(){
       // Code
   }
    
    func addChildVC(){
        // Setup Container View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               
       let eventListVC = storyboard.instantiateViewController(withIdentifier: "eventListViewController") as! EventListViewController
       addChild(eventListVC)
       
       let eventMapVC = storyboard.instantiateViewController(withIdentifier: "eventMapViewController") as! EventMapViewController
       addChild(eventMapVC)
       
       eventListVC.view.frame = self.view.bounds
       eventMapVC.view.frame = self.view.bounds
    
       eventListVC.delegate = self.delegate
       eventMapVC.delegate = self.delegate
       
       self.view.addSubview(eventListVC.view)
       self.view.addSubview(eventMapVC.view)
       
       eventListVC.didMove(toParent: self)
       eventMapVC.didMove(toParent: self)
        
       self.eventListViewController = eventListVC
       self.eventMapViewController = eventMapVC
        
       self.eventMapViewController?.view.isHidden = true

    }


}

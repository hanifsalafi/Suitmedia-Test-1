//
//  HomeViewController.swift
//  SuitmediaTest
//
//  Created by MacBook on 23/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

enum SelectedButton {
    case event
    case guest
}

class HomeViewController: UIViewController {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chooseEventButton: UIButton!
    @IBOutlet weak var chooseGuestButton: UIButton!
    
    var name: String?
    var selectedEvent: Event?
    var selectedGuest: GuestViewModel?
    var selectedBtn: SelectedButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customView()
        initGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (self.selectedBtn == .guest){
            self.checkGuestPhone()
        }
    }
    
    // MARK: - Initial Data
    
    public func initData(name: String?){
        self.name = name
    }
    
    // MARK: - Custom View
    
    func customView(){
        self.nameLabel.text = self.name
        
        chooseEventButton.layer.cornerRadius = chooseEventButton.frame.height / 2
        chooseGuestButton.layer.cornerRadius = chooseGuestButton.frame.height / 2

        chooseEventButton.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))
        chooseGuestButton.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))
    }
    
    // MARK: - Init Gesture
    
    func initGesture(){
        let chooseEventRecognizer = UITapGestureRecognizer()
        chooseEventRecognizer.addTarget(self, action: #selector(chooseEvent))
        self.chooseEventButton.addGestureRecognizer(chooseEventRecognizer)
        
        let chooseGuestRecognizer = UITapGestureRecognizer()
        chooseGuestRecognizer.addTarget(self, action: #selector(chooseGuest))
        self.chooseGuestButton.addGestureRecognizer(chooseGuestRecognizer)
    }

    @objc func chooseEvent(){
        let vc = storyboard?.instantiateViewController(identifier: "event") as! EventViewController
        vc.modalPresentationStyle = .fullScreen
        vc.initData(delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func chooseGuest(){
        let vc = storyboard?.instantiateViewController(identifier: "guest") as! GuestViewController
        vc.modalPresentationStyle = .fullScreen
        vc.initData(delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
   }
    
   // MARK: - Show Dialog View
    
    func showDialogView(image: String, title: String){
        let showAlert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 35, y: 80, width: 200, height: 175))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: image)
        
        showAlert.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: showAlert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: showAlert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(showAlert, animated: true, completion: nil)
    }
    
    func checkGuestPhone(){
        if let guestId = self.selectedGuest?.getId() {
            if (guestId % 2 == 0 && guestId % 3 != 0){
                showDialogView(image: "blackberry", title: "The Guest Detected Using BlackBerry Device")
            } else if (guestId % 3 == 0 && guestId % 2 != 0) {
                showDialogView(image: "android", title: "The Guest Detected Using Android Device")
            } else if (guestId % 2 == 0 && guestId % 3 == 0) {
                showDialogView(image: "ios", title: "The Guest Detected Using iOS Device")
            } else {
                showDialogView(image: "other_phone", title: "The Guest's Device is Not Detected")
            }
        }
    }
    
}

extension HomeViewController: EventDelegate, GuestDelegate {
    func sendSelectedEvent(event: Event) {
        self.selectedEvent = event 
        self.chooseEventButton.setTitle(event.name, for: .normal)
        self.selectedBtn = .event
    }
    
    func sendSelectedGuest(guest: GuestViewModel) {
        self.selectedGuest = guest
        self.chooseGuestButton.setTitle(guest.getFullName(), for: .normal)
        self.selectedBtn = .guest
    }
}

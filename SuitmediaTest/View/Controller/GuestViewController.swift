//
//  GuestViewController.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

protocol GuestDelegate {
    func sendSelectedGuest(guest: GuestViewModel)
}

class GuestViewController: UIViewController {
    
    @IBOutlet weak var guestCollectionView: UICollectionView!
    
    var guests: [GuestViewModel] = [GuestViewModel]()
    var delegate: GuestDelegate?
    var refreshControl: UIRefreshControl?
    var loadingView: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customView()
        requestData()
    }
    
    // MARK: - Initial Data
    
    public func initData(delegate: GuestDelegate?){
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
        
//        refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
//        if let refreshControl = refreshControl {
//            self.guestCollectionView.addSubview(refreshControl)
//        }
        
        loadingView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loadingView?.color = UIColor.orange
        loadingView?.center = CGPoint(x: self.guestCollectionView.bounds.size.width / 2, y:  self.guestCollectionView.bounds.size.height / 2)
        self.guestCollectionView.backgroundView = loadingView
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshTable(){
        
    }
    
    // MARK: - Request Data
    func requestData(){
//        self.loadingView?.showActivityIndicator(view: self.guestCollectionView.backgroundView)
        loadingView?.startAnimating()
        ServiceAPI.getGuests(completion: { (guests, message) in
            DispatchQueue.main.async {
                if let guestData = guests {
                    self.guests = guestData
                    self.loadingView?.stopAnimating()
                    self.guestCollectionView.reloadData()
                }
            }
        })
    }

}

extension GuestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.guests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guest", for: indexPath) as! GuestCollectionViewCell
        
        let guest = self.guests[indexPath.row]
        cell.guestImageView.downloaded(from: guest.getAvatar())
        cell.guestNameLabel.text = guest.getFullName()
        
        // Custom View Cell
        
        cell.guestImageView.layer.cornerRadius = cell.guestImageView.frame.height / 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGuest = self.guests[indexPath.row]
        
        // Send data to HomeViewController
        self.delegate?.sendSelectedGuest(guest: selectedGuest)
        
        // Back to HomeViewController
        self.navigationController?.popViewController(animated: true)
    }
    
}

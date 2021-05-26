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
    
    @IBOutlet weak var bottomIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bottomIndicatorVIewConstraint: NSLayoutConstraint!
    
    let serviceAPI = ServiceAPI()
    var guests: [GuestViewModel] = [GuestViewModel]()
    var delegate: GuestDelegate?
    var refreshControl: UIRefreshControl?
    var loadingView: UIActivityIndicatorView?
    var pageCount: Int = 1
    var isScrollDown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        requestData(page: 1, pagination: false)
    }
    
    // MARK: - Initial Data
    
    public func initData(delegate: GuestDelegate?){
       self.delegate = delegate
    }
    
    // MARK: - Setup View
    
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
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        if let refreshControl = refreshControl {
            self.guestCollectionView.addSubview(refreshControl)
        }
        
        loadingView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loadingView?.color = UIColor.orange
        loadingView?.center = CGPoint(x: self.guestCollectionView.bounds.size.width / 2, y:  self.guestCollectionView.bounds.size.height / 2)
        self.guestCollectionView.backgroundView = loadingView
        loadingView?.startAnimating()
        
        setupInfiniteScroll()
    }
    
    func setupInfiniteScroll(){
        self.bottomIndicatorView.stopAnimating()
        self.bottomIndicatorView.isHidden = true
    }
    
    @objc func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshTable(){
        requestData(page: 1, pagination: false)
    }
    
    // MARK: - Request Data
    func requestData(page: Int, pagination: Bool){
        serviceAPI.getGuests(page: page, per_page: 4, pagination: pagination, completion: { (guests, message) in
            DispatchQueue.main.async {
                if let guestData = guests {
                    if guestData.count > 0 {
                        if page == 1 {
                            self.guests = guestData
                        } else {
                            self.guests.append(contentsOf: guestData)
                        }
                        
                        self.pageCount = page
                        self.loadingView?.stopAnimating()
                        self.guestCollectionView.reloadData()
                        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                            self.refreshControl?.endRefreshing()
                        })
                    }
                    self.bottomIndicatorView.stopAnimating()
                    self.bottomIndicatorView.isHidden = true
                    self.serviceAPI.isPaginating = false
                }
            }
        })
    }
    
    func checkPrimeId(id: Int) -> Bool{
        guard id != 2 else { return true  }
        guard id >= 2 else { return false }
        guard id % 2 != 0 else { return false }
        return !stride(from: 3, through: Int(sqrt(Double(id))), by: 2).contains { id % $0 == 0 }
    }
}

extension GuestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.guests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guest", for: indexPath) as! GuestCollectionViewCell
        
        let guest = self.guests[indexPath.row]
        cell.configure(name: guest.getFullName(), imageURL: guest.getAvatar())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGuest = self.guests[indexPath.row]
        
        // Send data to HomeViewController
        self.delegate?.sendSelectedGuest(guest: selectedGuest)
        
        if self.checkPrimeId(id: selectedGuest.getId()){
            self.showToast(message: "The Guest ID is PRIME", font: UIFont.boldSystemFont(ofSize: 14.0))
        } else {
            self.showToast(message: "The Guest ID is NOT PRIME", font: UIFont.boldSystemFont(ofSize: 14.0))
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            // Back to HomeViewController
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position =  scrollView.contentOffset.y
        let limit = (self.guestCollectionView.contentSize.height / CGFloat(self.pageCount+2))-100
        // print("scroll : \(position) | batas : \(limit)")
        if limit > 0 && position > limit && guestCollectionView.isDragging {
            self.bottomIndicatorView.startAnimating()
            self.bottomIndicatorView.isHidden = false
            self.isScrollDown = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let refreshControl = self.refreshControl {
            if !refreshControl.isRefreshing && self.isScrollDown {
                if serviceAPI.isPaginating {
                   return
                }
                self.requestData(page: self.pageCount+1, pagination: true)
                self.isScrollDown = false
            }
        }
    }
    
}

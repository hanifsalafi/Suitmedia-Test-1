//
//  FormViewController.swift
//  SuitmediaTest
//
//  Created by MacBook on 23/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil);

       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);

    }
   
    @objc func keyboardDidShow(notification: Notification) {
        
        // Show Keyboard and Scroll Up the TextField
       let userInfo = notification.userInfo!
       let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
       let inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.size.height+80, right: 0)
       self.scrollView.contentInset = inset
       self.scrollView.scrollIndicatorInsets = inset
    }
   
    @objc func keyboardWillHide(notification: Notification) {
       
       // Hide Keyboard and Scroll Down the TextField
       let inset: UIEdgeInsets = UIEdgeInsets.zero
       self.scrollView.contentInset = inset
       self.scrollView.scrollIndicatorInsets = inset
    }


}

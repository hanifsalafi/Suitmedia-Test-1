//
//  WelcomeViewController.swift
//  SuitmediaTest
//
//  Created by MacBook on 23/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class WelcomeViewController: FormViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var palindromeTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var contentViewContainer: UIView!
    
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
    
    // MARK: - Custom View
    
    func customView(){
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
        palindromeTextField.layer.cornerRadius = palindromeTextField.frame.height / 2
        
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        
        checkButton.layer.cornerRadius = checkButton.frame.height / 2
        
        contentViewContainer.layer.cornerRadius = 10.0
        contentViewContainer.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))
    }
    
    // MARK: - Init Gesture
    
    func initGesture(){
        let viewRecognizer = UITapGestureRecognizer()
        viewRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(viewRecognizer)
        
        let nextButtonRecognizer = UITapGestureRecognizer()
        nextButtonRecognizer.addTarget(self, action: #selector(doNext))
        nextButton.addGestureRecognizer(nextButtonRecognizer)
    }
    
    @objc func didTapView(){
        self.view.endEditing(true)
    }
    
    // MARK: Do Function
    
    @objc func doNext(){
        let vc = storyboard?.instantiateViewController(identifier: "home") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        vc.initData(name: nameTextField.text ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

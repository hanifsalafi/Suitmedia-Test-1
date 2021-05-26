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
    
    var palindromeWord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
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

    // MARK: - Setup View

    func setupView(){
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
        palindromeTextField.layer.cornerRadius = palindromeTextField.frame.height / 2
        
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        checkButton.layer.cornerRadius = checkButton.frame.height / 2
        
        nextButton.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))
        checkButton.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))
        
        contentViewContainer.layer.cornerRadius = 10.0
        contentViewContainer.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))
        
        self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: 0, brightness: 1, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(0)
    }

    // MARK: - Init Gesture

    func initGesture(){
        let viewRecognizer = UITapGestureRecognizer()
        viewRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(viewRecognizer)
        
        let nextButtonRecognizer = UITapGestureRecognizer()
        nextButtonRecognizer.addTarget(self, action: #selector(doNext))
        nextButton.addGestureRecognizer(nextButtonRecognizer)
        
        let checkButtonRecognizer = UITapGestureRecognizer()
        checkButtonRecognizer.addTarget(self, action: #selector(doCheck))
        checkButton.addGestureRecognizer(checkButtonRecognizer)
    }

    @objc func didTapView(){
        self.view.endEditing(true)
    }

    // MARK: Do Function

    @objc func doNext(){
        if palindromeTextField.text != "" {
            if checkPalindrome() {
                let vc = storyboard?.instantiateViewController(identifier: "home") as! HomeViewController
                vc.modalPresentationStyle = .fullScreen
                vc.initData(name: nameTextField.text ?? "")
                self.navigationController?.pushViewController(vc, animated: true)
            } else{
                showAlert(view: self, title: "", message: "Please enter a correct palindrome word.")
            }
        } else {
            showAlert(view: self, title: "", message: "Please enter a palindrome word first.")
        }
    }

    @objc func doCheck(){
        if palindromeTextField.text != "" {
            if checkPalindrome() {
                showAlert(view: self, title: "Correct", message: "Your palindrome is correct")
            } else {
                showAlert(view: self, title: "Uncorrect", message: "Your palindrome is uncorrect. Try again!")
            }
        } else {
            showAlert(view: self, title: "", message: "Please enter a word palindrome first.")
        }
    }

    func checkPalindrome() -> Bool {
        var word = palindromeTextField.text!
        word = word.lowercased().components(separatedBy: .whitespacesAndNewlines).joined()
        if word == String(word.reversed()) {
            return true
        } else {
            return false
        }
    }

    func showAlert(view: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        
        view.present(alert, animated: true, completion: nil)
    }
    
}

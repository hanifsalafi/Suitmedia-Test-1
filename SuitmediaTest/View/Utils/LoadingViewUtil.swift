//
//  LoadingViewUtils.swift
//  SuitmediaTest
//
//  Created by MacBook on 25/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewUtil {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivityIndicator(view: UIView?) {
        if let view = view {
            let uiView: UIView = UIView()
            uiView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            container.frame = uiView.frame
            container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
            
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.center = uiView.center
            loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40.0, height: 40.0)
            activityIndicator.style = UIActivityIndicatorView.Style.large
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
            activityIndicator.color = UIColor.orange
            
            loadingView.addSubview(activityIndicator)
            container.addSubview(loadingView)
            view.addSubview(container)
            activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
        container.removeFromSuperview()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

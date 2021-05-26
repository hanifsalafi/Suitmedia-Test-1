//
//  EventCollectionViewCell.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var cellViewContainer: UIView!
    
    func configure(title: String, desc: String, image: String, date: String){
        eventImageView.image = UIImage(named: image)
        eventTitleLabel.text = title
        eventDescriptionLabel.text = desc
        eventDateLabel.text = date

        // Custom View Cell

        cellViewContainer.layer.cornerRadius = 15.0
        cellViewContainer.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))

        eventImageView.roundCorners([.topLeft, .bottomLeft], radius: 15.0)
    }
}

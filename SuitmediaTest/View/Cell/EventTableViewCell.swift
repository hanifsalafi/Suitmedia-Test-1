//
//  EventTableViewCell.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var cellViewContainer: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDescLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, desc: String, image: String, date: String){
        eventImageView.image = UIImage(named: image)
        eventTitleLabel.text = title
        eventDescLabel.text = desc
        eventDateLabel.text = date

        // Custom View Cell

        cellViewContainer.layer.cornerRadius = 15.0
        cellViewContainer.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))

        eventImageView.roundCorners([.topLeft, .bottomLeft], radius: 15.0)
    }

}

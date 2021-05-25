//
//  EventListViewController.swift
//  SuitmediaTest
//
//  Created by MacBook on 25/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventTableView: UITableView!
    
    var eventViewController = EventViewController()
    var delegate: EventDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventViewController.events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventListCell", for: indexPath) as! EventTableViewCell

        let event = self.eventViewController.events[indexPath.row]
        cell.eventImageView.image = UIImage(named: event.image)
        cell.eventTitleLabel.text = event.name
        cell.eventDescLabel.text = event.description
        cell.eventDateLabel.text = event.date

        // Custom View Cell

        cell.cellViewContainer.layer.cornerRadius = 15.0
        cell.cellViewContainer.addShadow(offset: CGSize(width: 0, height: 3), radius: CGFloat(4), opacity: Float(1))

        cell.eventImageView.roundCorners([.topLeft, .bottomLeft], radius: 15.0)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = self.eventViewController.events[indexPath.row]

        // Send data to HomeViewController
        self.delegate?.sendSelectedEvent(event: selectedEvent)

        // Back to HomeViewController
        self.navigationController?.popViewController(animated: true)
    }

}

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
    var events: [Event] = [Event]()
    var delegate: EventDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventListCell", for: indexPath) as! EventTableViewCell

        let event = self.events[indexPath.row]
        cell.configure(title: event.name, desc: event.description, image: event.image, date: event.date)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = self.events[indexPath.row]

        // Send data to HomeViewController
        self.delegate?.sendSelectedEvent(event: selectedEvent)

        // Back to HomeViewController
        self.navigationController?.popViewController(animated: true)
    }

}

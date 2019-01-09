//
//  ViewController.swift
//  lbta-contacts-list
//
//  Created by David D on 1/8/19.
//  Copyright © 2019 David D. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let cellId = "cellId"
    let names = [
        "Migos", "Yeezy", "Logic", "Khaled", "Cardi", "Kendrick", "J. Cole", "2Pac"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true

        // add cells into tableview
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.lightGray

        return label
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = names[indexPath.row]
        cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"

        return cell
    }
}


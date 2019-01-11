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

    let dNames = [
        "Drake", "Dr. Dre", "Diddy", "De La Soul"
    ]

    let eNames = [
        "Eazy E", "Eminem"
    ]

    let twoDArray = [
        ["Migos", "Yeezy", "Logic", "Khaled", "Cardi", "Kendrick", "J. Cole", "2Pac"],
        ["Drake", "Dr. Dre", "Diddy", "De La Soul"],
        ["Eazy E", "Eminem", "E-40"],
        ["Wu Tang Clan", "Lil Wayne"]
    ]

    @objc func handleShowIndexPath() {
        print("Attempting reload animation of indexPath...")

        // build all indexPaths to reload
        var indexPathsToReload = [IndexPath]()

        for index in twoDArray[0].indices {
            let indexPath = IndexPath(row: index, section: 0)
            indexPathsToReload.append(indexPath)
        }

        tableView.reloadRows(at: indexPathsToReload, with: .left)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
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
        return twoDArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return names.count
//        }
//
//        return dNames.count

        return twoDArray[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

//        let name = names[indexPath.row]
//        let name = indexPath.section == 0 ? names[indexPath.row] : dNames[indexPath.row]
        let name = twoDArray[indexPath.section][indexPath.row]

        cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"

        return cell
    }
}


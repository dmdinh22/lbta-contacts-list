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

    var twoDArray = [
        ["Migos", "Yeezy", "Logic", "Khaled", "Cardi", "Kendrick", "J. Cole", "2Pac"],
        ["Drake", "Dr. Dre", "Diddy", "De La Soul"],
        ["Eazy E", "Eminem", "E-40"],
        ["Wu Tang Clan", "Lil Wayne"]
    ]

    var showIndexPaths = false

    @objc func handleShowIndexPath() {
        print("Attempting reload animation of indexPath...")

        // build all indexPaths to reload
        var indexPathsToReload = [IndexPath]()

        for section in twoDArray.indices {
            for row in twoDArray[section].indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }

//        for index in twoDArray[0].indices {
//            let indexPath = IndexPath(row: index, section: 0)
//            indexPathsToReload.append(indexPath)
//        }

        showIndexPaths = !showIndexPaths

        let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : .left
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
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

        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        button.addTarget(self, action: #selector(handleExpandCloseSection), for: .touchUpInside)
        button.tag = section // set button tag to section clicked

        return button
    }

    @objc func handleExpandCloseSection(button: UIButton) {
        let section = button.tag
        
        // close section by deleting all rows within
        var indexPaths = [IndexPath]()
        for row in twoDArray[section].indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        // delete names in section in array
        twoDArray[section].removeAll()

        // delete rows from table
        tableView.deleteRows(at: indexPaths, with: .fade)
    }

    // set height of row
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
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

        let name = twoDArray[indexPath.section][indexPath.row]

        cell.textLabel?.text = name

        if showIndexPaths {
            cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"
        }

        return cell
    }
}


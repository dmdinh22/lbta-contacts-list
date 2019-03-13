//
//  ViewController.swift
//  lbta-contacts-list
//
//  Created by David D on 1/8/19.
//  Copyright © 2019 David D. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UITableViewController {
    let cellId = "cellId"

    // TODO: use Custom Delegation properly 
    func someMethodIWantToCall(cell: UITableViewCell) {
        // figure out which name we're clicking on
        guard let indexPathTapped = tableView.indexPath(for: cell) else {
            return
        }

        let contact = twoDArray[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)

        let hasFavorited = contact.hasFavorited

        twoDArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited

//        tableView.reloadRows(at: [indexPathTapped], with: .fade) - list gets jumpy when favoriting
        cell.accessoryView?.tintColor = hasFavorited ? .lightGray :.red
    }

    var twoDArray = [
        ExpandableNames(isExpanded: true, names: ["Migos", "Yeezy", "Logic", "Khaled", "Cardi", "Kendrick", "J. Cole", "2Pac"].map{ FavoritableContact(name: $0, hasFavorited: false)}),
        ExpandableNames(isExpanded: true, names: ["Drake", "Dr. Dre", "Diddy", "De La Soul"].map{ FavoritableContact(name: $0, hasFavorited: false)}),
        ExpandableNames(isExpanded: true, names: ["Eazy E", "Eminem", "E-40"].map{ FavoritableContact(name: $0, hasFavorited: false)}),
        ExpandableNames(isExpanded: true, names: [FavoritableContact(name: "Wu Tang Clan", hasFavorited: false)])
    ]

    private func fetchContacts() {
        print("Attempting to fetch contacts today...")

        let store = CNContactStore()

        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access:", err)
                return
            }

            if granted {
                print("Access granted")

                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]

                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

                do {
                    var favoritableContacts = [FavoritableContact]()

                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in

                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")

                        favoritableContacts.append(FavoritableContact(name: "\(contact.givenName) \(contact.familyName)", hasFavorited: false))
                    })

                    let names = ExpandableNames(isExpanded: true, names: favoritableContacts)
                    self.twoDArray = [names]
                    
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
            } else {
                print("Access denied..")
            }
        }
    }

    var showIndexPaths = false

    @objc func handleShowIndexPath() {

        print("Attempting reload animation of indexPath...")

        // build all indexPaths to reload
        var indexPathsToReload = [IndexPath]()

        for section in twoDArray.indices {
            for row in twoDArray[section].names.indices {
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

        fetchContacts()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true

        // add cells into tableview
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
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
        for row in twoDArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        // flag expanded prop
        let isExpanded = twoDArray[section].isExpanded
        twoDArray[section].isExpanded = !isExpanded

        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)

        if isExpanded {
            // delete rows from table section
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            // add rows to table section
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }

    // set height of row
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // handle closed section case
        if !twoDArray[section].isExpanded {
            return 0
        }

        return twoDArray[section].names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        // linking VC to cells
        cell.link = self

        let contact = twoDArray[indexPath.section].names[indexPath.row]

        cell.textLabel?.text = contact.name
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray

        if showIndexPaths {
            cell.textLabel?.text = "\(contact.name) Section:\(indexPath.section) Row:\(indexPath.row)"
        }

        return cell
    }
}


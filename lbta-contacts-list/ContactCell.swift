import UIKit

class ContactCell: UITableViewCell {

    var link: ViewController?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // render star on the right of cell
        let starButton = UIButton(type: .system)

        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = .lightGray
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)

        accessoryView = starButton
    }

    @objc private func handleMarkAsFavorite() {

        link?.someMethodIWantToCall(cell: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

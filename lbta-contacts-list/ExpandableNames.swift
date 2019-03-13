import Foundation

struct ExpandableNames {
    var isExpanded: Bool
    var names: [FavoritableContact]
}

struct FavoritableContact {
    let name: String
    var hasFavorited: Bool
}

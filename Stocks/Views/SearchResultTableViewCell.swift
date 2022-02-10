//
//  SearchResultTableViewCell.swift
//  Stocks
//
//  Created by Ivan Tolchainov on 18.01.2022.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

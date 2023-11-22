//
//  TableViewCell.swift
//  World News Demo
//
//  Created by Александр Родителев on 21.11.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with book: BookPreview){
        bookImageView.downloaded(from: book.imageUrl)
        titleLabel.text = book.title
        descriptionLabel.text = book.description
        authorLabel.text = book.author
    }
    
}



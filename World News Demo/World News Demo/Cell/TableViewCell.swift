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
    @IBOutlet var favoriteButton: UIButton!
    
    var completion:( () -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    func configure(with book: Book){
        bookImageView.downloaded(from: book.bookImage)
        titleLabel.text = book.title
        descriptionLabel.text = book.description
        authorLabel.text = book.author
    }
    
    func configureSaved(with book: BookEntity){
        bookImageView.downloaded(from: book.image)
        titleLabel.text = book.title
        descriptionLabel.text = book.discription
        authorLabel.text = book.author
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        completion!()
    }
    
}



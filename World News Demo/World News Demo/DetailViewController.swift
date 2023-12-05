//
//  DetailViewController.swift
//  World News Demo
//
//  Created by Александр Родителев on 05.12.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var centralLabel: UILabel!
    @IBOutlet weak var authorBookLabel: UILabel!
    @IBOutlet weak var discriptionBookLabel: UILabel!
    @IBOutlet weak var buyBookNowLabel: UILabel!
    @IBOutlet var buyBookButtonOutlet: UIButton!
    
    var book: Book?
    override func viewDidLoad() {
        super.viewDidLoad()
        buyBookButtonOutlet.layer.cornerRadius = 18
        if let unwrappedBook = book{
            bookImageView.downloaded(from: unwrappedBook.bookImage)
            centralLabel.text = unwrappedBook.title
            authorBookLabel.text = unwrappedBook.author
            discriptionBookLabel.text = unwrappedBook.description
        } else {
            print("Book is nil")
        }
    }
    @IBAction func buyBookButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.bookUrl = book?.amazonProductURL ?? "https://example.com/default"
         self.present(vc, animated: true)
    }
    
}

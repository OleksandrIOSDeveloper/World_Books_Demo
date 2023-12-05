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
    @IBOutlet weak var buyBookButtonOutlet: UIButton!
    
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
    
    
    @IBAction func downloadSheet(sender: AnyObject) {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Buy a book on Amazon", style: .default) { action -> Void in
            
            print("First Action pressed")
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Buy a book on Apple Books", style: .default) { action -> Void in
            
            print("Second Action pressed")
        }
        
        let thirdAction: UIAlertAction = UIAlertAction(title: "Buy a book on Barnes and Noble", style: .default) { action -> Void in
            
            print("Third Action pressed")
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(thirdAction)
        actionSheetController.addAction(cancelAction)
        
        
        // present an actionSheet...
        // present(actionSheetController, animated: true, completion: nil)   // doesn't work for iPad
        
            //   actionSheetController.popoverPresentationController?.sourceView = yourSourceViewName // works for both iPhone & iPad
        
        present(actionSheetController, animated: true) {
            print("option menu presented")
            
        }
    }
//    @IBAction func buyBookButton(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//        vc.bookUrl = book?.amazonProductURL ?? "https://example.com/default"
//         self.present(vc, animated: true)
//    }
//
//
}

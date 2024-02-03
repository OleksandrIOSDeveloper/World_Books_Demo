//
//  ViewController.swift
//  World News Demo
//
//  Created by Александр Родителев on 21.09.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameListLabel: UILabel!
    @IBOutlet var buttonStackVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var buttonStackView: UIStackView!
    
    var bookService = BooksService()
    var isSavedBooks = false
    var coreDataService = CoreDataService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getBooks()
        coreDataService.convertToBookEntities(managedObjects: coreDataService.loadSelectedBook())
    }
    
    private func setupUI() {
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        nameListLabel.text = isSavedBooks ? "Saved Books" : bookService.nameList
        buttonStackView.isHidden = isSavedBooks ? true : false
        buttonStackVIewHeightConstraint.constant = isSavedBooks ? 0 : 40
    }
    
    @IBAction func previousButton(_ sender: Any) {
        bookService.switchPage(isNext: false, completion: {
            self.updateData()
        })
    }
    
    @IBAction func nextButton(_ sender: Any) {
        bookService.switchPage(isNext: true, completion: {
            self.updateData()
        })
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        sender.direction = .right
        bookService.switchPage(isNext: false, completion: {
            self.updateData()
        })
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        sender.direction = .left
        bookService.switchPage(isNext: true, completion: {
            self.updateData()
        })
    }
    
    private func updateData() {
        nameListLabel.text = isSavedBooks ? "Saved Books" : bookService.nameList
        tableView.reloadData()
    }
    
    private func getBooks() {
        bookService.fetchBooks { result in
            if let error = result {
                print(error)
            } else {
                self.tableView.reloadData()
                self.nameListLabel.text = self.isSavedBooks ? "Saved Books" : self.bookService.nameList
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSavedBooks ? coreDataService.bookEntities.count : bookService.booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        if isSavedBooks {
            cell.configureSaved(with: coreDataService.bookEntities[indexPath.row])
        } else {
            cell.configure(with: bookService.booksArray[indexPath.row])
        }
        cell.completion = {
            self.coreDataService.saveSelectedBook(
                author: self.bookService.booksArray[indexPath.row].author,
                discription: self.bookService.booksArray[indexPath.row].description,
                image: self.bookService.booksArray[indexPath.row].bookImage,
                title: self.bookService.booksArray[indexPath.row].title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if isSavedBooks {
            viewController.savedBook = coreDataService.bookEntities[indexPath.row]
        } else {
            viewController.book = bookService.booksArray[indexPath.row]
        }
        self.present(viewController, animated: true)
    }
}

//
//  ViewController.swift
//  World News Demo
//
//  Created by Александр Родителев on 21.09.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITabBarControllerDelegate {
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(tabBarIndexChanged), name: NSNotification.Name(rawValue: "TabBarIndexChanged"), object: nil)
    }
    
    @objc func tabBarIndexChanged() {
        coreDataService.updateBookEntities()
        tableView.reloadData()
    }
    
    deinit {
        // Удаляем наблюдателя при уничтожении ViewController
        NotificationCenter.default.removeObserver(self)
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
    
    func checkIfBookIsSaved(with title: String) -> Bool {
        return coreDataService.bookEntities.contains { $0.title == title }
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
            cell.isBookSaved = checkIfBookIsSaved(with: bookService.booksArray[indexPath.row].title)
            cell.configure(with: bookService.booksArray[indexPath.row])
        }
        
        cell.completion = { [weak self] in
            guard let self = self else { return }
            if isSavedBooks {
                let title = self.coreDataService.bookEntities[indexPath.row].title
                self.coreDataService.deleteBook(title: title)
            } else {
                let book = self.bookService.booksArray[indexPath.row]
                let isBookSaved = checkIfBookIsSaved(with: book.title)
                if isBookSaved {
                    self.coreDataService.deleteBook(title: book.title)
                    cell.favoriteButton.setImage(UIImage(systemName: "star.square"), for: .normal)
                } else {
                    self.coreDataService.saveSelectedBook(
                        author: book.author,
                        discription: book.description,
                        image: book.bookImage ?? "00",
                        title: book.title
                    )
                    cell.favoriteButton.setImage(UIImage(systemName: "star.square.fill"), for: .normal)
                }
            }
            self.tableView.reloadData()
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

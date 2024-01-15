//
//  ViewController.swift
//  World News Demo
//
//  Created by Александр Родителев on 21.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameListLabel: UILabel!
    
    var bookService = BooksService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        setupUI()
        getBooks()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        pageLabel.text = String(bookService.page)
        nameListLabel.text = bookService.nameList
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
    
   
    
    private func updateData() {
        pageLabel.text = String(bookService.page)
        nameListLabel.text = bookService.nameList
        tableView.reloadData()
    }
    
    private func getBooks() {
        bookService.fetchBooks { result in
            if let error = result {
                print(error)
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookService.booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.configure(with: bookService.booksArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.book = bookService.booksArray[indexPath.row]
        self.present(viewController, animated: true)
    }
}

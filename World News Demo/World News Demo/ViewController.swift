//
//  ViewController.swift
//  World News Demo
//
//  Created by Александр Родителев on 21.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageButton: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var arrayOfBooks = [BookPreview(title: "IRON FLAME", description:"The second book in the Empyrean series. Violet Sorrengail’s next round of training might require her to betray the man she loves.", author: "Rebecca Yarros", imageUrl: "https://storage.googleapis.com/du-prd/books/images/9781649374172.jpg"),BookPreview(title: "RESURRECTION WALK", description:"The seventh book in the Lincoln Lawyer series. Haller and Bosch team up to prove the innocence of a woman in prison for killing her husband.", author: "Michael Connellys", imageUrl: "https://storage.googleapis.com/du-prd/books/images/9780316563765.jpg"),BookPreview(title: "BOOKSHOPS & BONEDUST", description: "In a prequel to “Legends & Lattes,\" an orc who was hurt during a battle winds up in a sleepy beach town called Murk.", author: "Travis Baldree", imageUrl: "https://storage.googleapis.com/du-prd/books/images/9781250886101.jpg"),BookPreview(title: "THE SECRET", description: "The 28th book in the Jack Reacher series. It’s 1992 and Reacher looks into the cause of a string of mysterious deaths.", author: "Lee Child and Andrew Child", imageUrl: "https://storage.googleapis.com/du-prd/books/images/9781984818584.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    
    }

    @IBAction func previousButton(_ sender: Any) {
    }
    @IBAction func nextButton(_ sender: Any) {
    }
    
 
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfBooks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.configure(with: arrayOfBooks[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190 // Замените это значение на ваше желаемое значение высоты
    }
}

//
//  WebViewController.swift
//  World News Demo
//
//  Created by Александр Родителев on 05.12.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var bookUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myUrl = URL(string: bookUrl) else { return }
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
    }
    
}

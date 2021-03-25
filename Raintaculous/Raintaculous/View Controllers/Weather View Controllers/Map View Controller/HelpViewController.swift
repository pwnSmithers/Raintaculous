//
//  HelpViewController.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let url = URL(string: "https://openweathermap.force.com/s/topic/0TO3i000000D2joGAC/faq")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension HelpViewController: WKNavigationDelegate{
    
}

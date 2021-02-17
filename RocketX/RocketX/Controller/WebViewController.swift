//
//  WebViewController.swift
//  RocketX
//
//  Created by Jon Luengo Muntion on 16/2/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    var spinner: UIActivityIndicatorView!
    var wikipediaURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []

        configureWebView()
    }
    
    func configureWebView() {
        let webViewConf = WKWebViewConfiguration()
        
        webView = WKWebView(frame: view.frame, configuration: webViewConf)
        webView.navigationDelegate = self
        
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never;
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        
        spinner = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.width/3, y: self.view.frame.height/2, width: 10, height: 10))
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.gray

        view.addSubview(spinner)
        webView.bringSubviewToFront(spinner)
        
        webView.load(URLRequest(url: wikipediaURL))
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
        let alert = UIAlertController(title: NSLocalizedString("conection_error", comment: ""), message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}

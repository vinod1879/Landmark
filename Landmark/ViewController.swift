//
//  ViewController.swift
//  Landmark
//
//  Created by Vinod Vishwanath on 26/09/16.
//  Copyright © 2016 Vinod Vishwanath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var dataController = DataController()
    
    @IBOutlet private weak var webView : UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataController.fetchData { error in
            
            print(error)
            if let elementHTML = self.dataController.targetElementHTMLString {
                
                let url = NSURL(string: Config.HostURLString)
                
                let html = Config.Header + elementHTML + Config.footer
                
                self.webView.loadHTMLString(html, baseURL: url)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UIWebViewDelegate {
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URLString == Config.HostURLString {
        
            return true
        }
        return false
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    
    }
}


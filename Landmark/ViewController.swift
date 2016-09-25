//
//  ViewController.swift
//  Landmark
//
//  Created by Vinod Vishwanath on 26/09/16.
//  Copyright © 2016 Vinod Vishwanath. All rights reserved.
//

import UIKit

private let header = "<html>\n<head>\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, user-scalable=no\">\n<link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"/_ui/responsive/landmark/css/lms.min.css\">\n<script src=\"/_ui/responsive/landmark/js/vendor/require.min.js\" data-main=\"/_ui/responsive/landmark/js/lms.min\"></script>\n<link href=\"https://fonts.googleapis.com/css?family=Lato:400,300,100,700,900\" rel=\"stylesheet\" type=\"text/css\"></head>\n<body class=\"modal-open page-brandlifestylepage page-brandmaxpage page-brandBabyshoppage page-brandSplashpage page-brandcenterpointpage page-brandShoemartpage page-brandHomecentrepage pageType-ContentPage template-pages-layout-lmgBrandPageLayout pageLabel-brandlifestylepage language-en brandProtection staticPages i18n-ae\">\n<div id=\"wrapper\" style=\"padding-top:0px;\">\n<main id=\"main-part\" style=\"min-height: auto;\">\n<div class=\"container-fluid\" id=\"container-main-area\">"

private let footer = "\n\n\n</div>\n</main>\n</div>\n</body>\n</html>"

class ViewController: UIViewController {
    
    private var dataController = DataController()
    
    @IBOutlet private weak var webView : UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataController.fetchData { error in
            
            print(error)
            if let str = self.dataController.carouselString {
                
                let url = NSURL(string: "http://landmarkshops.com")
                
                let html = header + str + footer
                var sanitized = html.stringByReplacingOccurrencesOfString("\t", withString: "")
                sanitized = sanitized.stringByReplacingOccurrencesOfString("\n", withString: "")
                
                self.webView.loadHTMLString(sanitized, baseURL: url)
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
        
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
    
    }
}


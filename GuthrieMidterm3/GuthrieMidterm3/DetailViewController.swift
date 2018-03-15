//
//  DetailViewController.swift
//  GuthrieMidterm3
//
//  Created by Kaelen Guthrie on 3/15/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var detailItem: String?
    
    func configureView(){
        if let url = detailItem{
            if url != "null"{ loadWebPage(url)
            } }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    func loadWebPage(_ urlString: String){
        //the urlString should be a propery formed url
        //creates a NSURL object
        print("URLSTRING", urlString)
        let url = URL(string: urlString)
        //create a NSURLRequest object
        let request = URLRequest(url: url!)
        //load the NSURLRequest object in our web view
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


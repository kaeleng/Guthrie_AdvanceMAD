//
//  SecondViewController.swift
//  Lab1
//
//  Created by Kaelen Guthrie on 2/4/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func gotobooks(_ sender: UIButton) {
        if(UIApplication.shared.canOpenURL(URL(string:"ibook://")!)){
            UIApplication.shared.open(URL(string: "ibooks://")!, options:[:],completionHandler: nil)
        }
        else{
            if(UIApplication.shared.canOpenURL(URL(string: "https://itunes.apple.com/us/app/ibooks/id364709193?mt=8")!)){
                UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/ibooks/id364709193?mt=8")!, options:[:], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


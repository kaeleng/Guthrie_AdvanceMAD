//
//  AddViewController.swift
//  GuthrieMidterm3
//
//  Created by Kaelen Guthrie on 3/15/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var addedRestaurant = String()
    var addedURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "saveSegue"){
            if((nameTextField.text?.isEmpty) == false && (urlTextField.text?.isEmpty) == false){
                addedRestaurant = nameTextField.text!
                addedURL = urlTextField.text!
                //print(addedURL)
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

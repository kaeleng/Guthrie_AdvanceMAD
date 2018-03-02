//
//  JokeViewController.swift
//  Lab4
//
//  Created by Kaelen Guthrie on 3/1/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {

    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var punchLabel: UILabel!
    
    var joke = String()
    var punch = String()
    
    override func viewWillAppear(_ animated: Bool){
        jokeLabel.text = joke
        punchLabel.text = punch
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

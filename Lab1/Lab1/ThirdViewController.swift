//
//  ThirdViewController.swift
//  Lab1
//
//  Created by Kaelen Guthrie on 2/8/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit
import MediaPlayer

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var nowPlaying: UILabel!
    
    let myMusicPlayer = MPMusicPlayerController()
    let myMediaQuery = MPMediaQuery.songs()

    @IBAction func actionButton(_ sender: UIButton) {
        if sender.currentTitle == "Play"{
            myMusicPlayer.setQueue(with: myMediaQuery)
            myMusicPlayer.play()
            sender.setTitle("Stop",for:[])
        }
        else if sender.currentTitle == "Stop"{
            myMusicPlayer.pause()
            sender.setTitle("Stop",for:[])
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

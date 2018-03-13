//
//  Adventure.swift
//  Project1
//
//  Created by Kaelen Guthrie on 2/28/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import Foundation

struct Adventure{
    var imagePath: URL?
    var imageName: String?
    var destinationName: String?
 //   var destinationArray = [String]()
    
    var entryArray = [[String:Any]]()
    
    init(imageName: String, imagePath: URL, destinationName: String){
        self.imageName = imageName
        self.imagePath = imagePath
        self.destinationName = destinationName
        //self.entryArray = entryArray
    }
}

//
//  FirstViewController.swift
//  Lab1
//
//  Created by Kaelen Guthrie on 2/4/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var genrePicker: UIPickerView!
    @IBOutlet weak var genreLabel: UILabel!
    
    let genreComponent = 0
    let bookComponent = 1
    var genreBooks = [String: [String]]()
    var genre = [String]()
    var books = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == genreComponent{
            return genre.count
        }
        else{
            return books.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == genreComponent{
            return genre[row]
        }
        else{
            return books[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == genreComponent{
            let selectedGenre = genre[row]
            books = genreBooks[selectedGenre]!
            genrePicker.reloadComponent(bookComponent)
            genrePicker.selectRow(0, inComponent: bookComponent, animated: true)
        }
        let genrerow = pickerView.selectedRow(inComponent: genreComponent)
        let bookrow = pickerView.selectedRow(inComponent: bookComponent)
        genreLabel.text = "You like \(books[bookrow]) which is a \(genre[genrerow]) book"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let pathURL = Bundle.main.url(forResource: "genrebooks", withExtension: "plist"){
            let plistdecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                genreBooks = try plistdecoder.decode([String:[String]].self, from: data)
                genre = Array(genreBooks.keys)
                books = genreBooks[genre[0]]! as [String]
            }
            catch{
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  AddPostViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/11/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class AddPostViewController: UIViewController {
    @IBOutlet weak var butttonClick: UIButton!
    @IBOutlet weak var loadingData: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupElement()  {
        ButtonUtilities.ButtonRadius_All(butttonClick)
        ButtonUtilities.styleButton(butttonClick)
        
        ButtonUtilities.ButtonRadius_All(loadingData)
        ButtonUtilities.styleButton(loadingData)
        
        
    }
    @IBAction func LoadFirebaseData(_ sender: Any){
        
        let abcd = getData()
        
        
        var bnv:String = ""
        abcd.read({ (document) in
            bnv = document
            print(bnv)
        }, _fieldname: "firstname")
        abcd.read({ (document) in
            bnv = document
            print(bnv)
        }, _fieldname: "phoneNumber")
        abcd.read({ (document) in
            bnv = document
            print(bnv)
        }, _fieldname: "facebookurl")
        
        abcd.read({ (document) in
            bnv = document
            print(bnv)
        }, _fieldname: "imageURL")
        
        
    }
}

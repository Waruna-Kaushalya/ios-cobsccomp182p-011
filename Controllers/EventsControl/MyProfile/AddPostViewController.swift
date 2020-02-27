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
import FirebaseFirestore
import FirebaseStorage
import Kingfisher


class AddPostViewController: UIViewController {
    @IBOutlet weak var butttonClick: UIButton!
    @IBOutlet weak var loadingData: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textTest: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        textTest.styleTextField()
//        
         setupElement()
        let abcd = getData()
        
        abcd.read({ (document) in
            let url = URL(string: document)
            self.profileImage.kf.setImage(with: url)
        }, _fieldname: "imageURL")

        
    }
    
    func setupElement()  {
//        let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
//        imageView.backgroundColor = UIColor.redColor()
//        profileImage.layer.cornerRadius = 25
//        profileImage.clipsToBounds = true
        
//        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
//        profileImage.clipsToBounds = true
         profileImage.roundedImage()
        butttonClick.buttonRadiusAll()
        butttonClick.styleButton()
        
        loadingData.buttonRadiusAll()
        loadingData.styleButton()
        
//        ButtonUtilities.ButtonRadius_All(butttonClick)
//        ButtonUtilities.styleButton(butttonClick)
//
//        ButtonUtilities.ButtonRadius_All(loadingData)
//        ButtonUtilities.styleButton(loadingData)
        
        
    }
    @IBAction func LoadFirebaseData(_ sender: Any){
        
//        let abcd = getData()
//        var  gbh:String = ""
//        
//        let bnv:String = ""
//        abcd.read({ (document) in
//            bnv = document
//            print(bnv)
//        }, _fieldname: "firstname")
//        abcd.read({ (document) in
//            bnv = document
//            print(bnv)
//        }, _fieldname: "phoneNumber")
        let abcd = getData()
        abcd.read({ (document) in
//            bnv = document
             print(document)
//            return document
           
        }, _fieldname: "facebookurl")
        
//        print(ff)
        
//        abcd.read({ (document) in
//            bnv = document
//            print(bnv)
//            let url = URL(string: bnv)
//            self.profileImage.kf.setImage(with: url)
//        }, _fieldname: "imageURL")
//
        
        
        
    }
   
}

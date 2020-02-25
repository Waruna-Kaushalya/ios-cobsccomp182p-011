//
//  EventDetailsViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/21/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class EventDetailsViewController: UIViewController {
    
    var event:Event?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventAdedDate: UILabel!
    @IBOutlet weak var goingBtn: UIButton!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var goingCountLabel: UILabel!
    
    let eventAtendingDB = PushGoingDataFirbase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileImage.roundedImage()
        
        goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
        
        let state = GoingCountStruct.goingOrNot
        print("My view state:\(state)")
        
        if state == true{
            goingBtn.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
            goingBtn.tag = 1
            
            
            goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
            
        }else{
            goingBtn.setImage(UIImage(named: "GoingBtn"), for: .normal)
            goingBtn.tag = 0
            
            goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber )")
            
        }
        
        setElement()
        
    }
    @IBAction func goingBtnClicked(_ sender: UIButton) {
        //        print(currentUserId[0])
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            if goingBtn.tag == 0 {
                
                goingBtn.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                goingBtn.tag = 1
                
                GoingCountStruct.goingCountNumber = GoingCountStruct.goingCountNumber + 1
                
                goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingUserList.append( UserStruct.currentUserId )
                
                GoingCountStruct.goingOrNot = true
                
                eventAtendingDB.eventAtendingDB()
                //                lick()
                print("going")
                
            }else {
                
                goingBtn.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingBtn.tag = 0
                
                GoingCountStruct.goingCountNumber = GoingCountStruct.goingCountNumber - 1
                goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingUserList = GoingCountStruct.goingUserList.filter {$0 !=  UserStruct.currentUserId }
                
                GoingCountStruct.goingOrNot = false
                
                eventAtendingDB.eventAtendingDB()
                //                lick()
                print("not going")
            }
            
        }else{
            
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
            
        }
    }
    
    
    func setElement(){
        eventTitle.text = event?.title
        //        eventImage
        eventDescriptionLabel.text = event?.eventDescription
        
        let url = URL(string: event?.iamage ?? "")
        self.eventImage.kf.setImage(with: url)
        //        eventLocation
        //        eventAdedDate
        
        //        userProfileImage
        userName.text = event?.userFirstName
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        let trans = TransitionController()
        trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: self)
        //                navigationController?.popViewController(animated: true)
        //
        //                dismiss(animated: true, completion: nil)
        //
        //        let eventsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeTableViewCell
        //
        ////        eventsController.dfgt()
        ////        self.present(eventsController, animated: true, completion: nil)
        //
        //            eventsController.dfgt()
        //        self.present(viewName, animated: true, completion: nil)
    }
    
    
    
}

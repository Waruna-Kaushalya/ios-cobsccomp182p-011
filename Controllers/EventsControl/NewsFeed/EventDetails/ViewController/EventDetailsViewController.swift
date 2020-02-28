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

class EventDetailsViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var commentTableView: UITableView!
    var event:EventModel?
    
    var commentsList:[CommentsModel] = []
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventAdedDate: UILabel!
    @IBOutlet weak var goingBtn: UIButton!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var eventEditBtn: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    let eventAtendingDB = AddGoingCountDataToFirebase()
    let alertMSG = AlertMessages()
    let checkUserLoginStatus = CheckUserLoginStatus()
    
    var eventIdentifire:[String] = [""]
    
    var currentUserId:[String] = [""]
    
    let checkUserStatus = CheckUserLoginStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventIdentifire[0] = event!.eventIdentifire
        
        getGoingDataFirebase()
        
        buttonAccessControll()
        
        currentUserDetaiilsRetriving()
    }
    
    
    @IBAction func goingBtnClicked(_ sender: UIButton) {
        
        if checkUserStatus.checkUserLoginStatus() == true {
            if goingBtn.tag == 0 {
                //Going
                goingBtn.tag = 1
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber  + 1
                
                goingBtn.goingButton(count: "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingUserList.append(currentUserId[0])
                
                GoingCountStruct.goingOrNot = true
                
                eventAtendingDB.addGoingCountDataToFirebase(eventIdentifire: eventIdentifire[0])
                
            }else {
                
                //not going
                
                goingBtn.tag = 0
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber  - 1
                
                goingBtn.notGoing(count: "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingUserList = GoingCountStruct.goingUserList.filter {$0 !=  currentUserId[0] }
                
                GoingCountStruct.goingOrNot = false
                
                eventAtendingDB.addGoingCountDataToFirebase(eventIdentifire: eventIdentifire[0])
            }
        }else{
            
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
        }
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        let trans = TransitionController()
        trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: self)
    }
    
    @IBAction func eventEditAction(_ sender: Any) {
        let transition = TransitionController()
        transition.trancVC(_viewCIdentifire: "EventEditVC", _viewCFrom: self)
    }
    
    
    @IBAction func postButtonAction(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            alertMSG.warningAlertMessage(_AlertMessage: error!, _viewCFrom: self)
        }else{
            
            let uuid = UUID().uuidString
            Comments.commentID = uuid
            
            Comments.comment = commentTextField.text!
            
            let commentAdd = AddCommentsToFireBase()
            
            commentAdd.addCommentsToFireBase()
            
            retrieveComments()
            
            self.commentTableView.reloadData()
        }
    }
}

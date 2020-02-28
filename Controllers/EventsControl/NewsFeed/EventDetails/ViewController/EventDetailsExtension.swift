//
//  EventDetailsExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

extension EventDetailsViewController:UITableViewDataSource, UITableViewDelegate{
    
    func currentUserDetaiilsRetriving(){
        
        if checkUserLoginStatus.checkUserLoginStatus() == true {
            Comments.userID  = Auth.auth().currentUser!.uid as String
            
            retrieveComments()
            
            let currentUserDetails = RetrieveCurrentUserDetails()
            currentUserDetails.retrieveGoingDataFromFirebase()
        }else{
            postButton.isHidden = true
            //            commentTextField.isHidden = true
        }
    }
    
    func buttonAccessControll(){
        
        if checkUserStatus.checkUserLoginStatus() != true || Auth.auth().currentUser!.uid != event!.userID  {
            eventEditBtn.isHidden = true
        }
    }
    
    func getGoingDataFirebase(){
        
        let docRef = Firestore.firestore().collection("event").whereField("eventID", isEqualTo: self.event!.eventIdentifire)
        
        print(self.event!.eventIdentifire)
        
        docRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else if querySnapshot!.documents.count != 1 {
                print("More than one documents or none")
            } else {
                let document = querySnapshot!.documents.first
                let dataDescription = document?.data()
                
                GoingCountStruct.goingCountNumber = dataDescription?["goingCount"] as! Int
                
                GoingCountStruct.goingUserList = dataDescription?["goingUsers"]  as! [String]
                
                if GoingCountStruct.goingUserList.count == 0  {
                    print("going count nil")
                    GoingCountStruct.goingCountNumber = 0
                }
            }
            
            DispatchQueue.main.async {
                self.setElement()
                self.setPLike()
                
                print("BBB")
            }
        }
    }
    
    func setPLike(){
        
        if checkUserStatus.checkUserLoginStatus() == true {
            currentUserId[0] = Auth.auth().currentUser!.uid
            
            var flagC:[Bool] = [false]
            
            if GoingCountStruct.goingUserList.count != 0 && GoingCountStruct.goingCountNumber  != 0{
                for i in 0..<GoingCountStruct.goingUserList.count {
                    
                    if GoingCountStruct.goingUserList[i] ==  currentUserId[0]  {
                        flagC[0] = true
                    }else{
                        flagC[0] = false
                    }
                }
                
                if flagC[0] == true{
                    
                    goingBtn.goingButton(count: "\(GoingCountStruct.goingCountNumber)")
                    goingBtn.tag = 1
                    
                    GoingCountStruct.goingOrNot = true
                    
                }else{
                    
                    goingBtn.notGoing(count: "\(GoingCountStruct.goingCountNumber)")
                    goingBtn.tag = 0
                    GoingCountStruct.goingOrNot = false
                }
            }
            else{
                
                goingBtn.notGoing(count: "\(GoingCountStruct.goingCountNumber)")
                goingBtn.tag = 0
                GoingCountStruct.goingOrNot = false
            }
        }else{
            goingBtn.isHidden = false
            
        }
    }
    
    func setElement(){
        
        postButton.styleButton()
        postButton.buttonRadiusAll()
        
        userProfileImage.roundedImage()
        
        eventTitle.text = event?.title
        eventDescriptionLabel.text = event?.eventDescription
        
        let url = URL(string: event?.iamage ?? "")
        self.eventImage.kf.setImage(with: url)
        
        eventLocation.text = event?.userCurrentLocation
        
        eventAdedDate.text = event?.eventAddedDate
        
        let urll = URL(string: event?.userProfileImage ?? "")
        self.userProfileImage.kf.setImage(with: urll)
        
        userName.text = event?.userFirstName
        
        UpdateEventStruct.eventID = event!.eventIdentifire
        UpdateEventStruct.eventDescription = event!.eventDescription
        UpdateEventStruct.eventTitle = event!.title
        Comments.EventID = event!.eventIdentifire
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = commentsList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCellIdentifier") as! CommentCell
        
        cell.setComments(comment: comment)
        
        return cell
    }
    
    func retrieveComments(){
        
        self.commentsList.removeAll()
        
        let dataRef = Firestore.firestore().collection("comments").whereField("EventID", isEqualTo: event?.eventIdentifire)
        dataRef.getDocuments { (querySnapshot, err) in
            
            for document in querySnapshot!.documents {
                
                let dataDescription = document.data()
                
                let commentIDV = dataDescription["commentID"] as? String
                let EventIDV = dataDescription["EventID"] as? String
                let userIDV = dataDescription["userID"] as? String
                let userNameV = dataDescription["userName"] as? String
                let userProfileImageURLV = dataDescription["userProfileImageURL"] as? String
                let commentV = dataDescription["comment"] as? String
                let commentDate = dataDescription["commentDate"] as? String
                
                let comment:CommentsModel = CommentsModel(commentID: commentIDV!, EventID: EventIDV!, userName: userNameV!, userID: userIDV!, userProfileImageURL: userProfileImageURLV!, comment: commentV!, commentDate:commentDate! )
                
                DispatchQueue.main.async {
                    self.commentsList.append(comment)
                    self.commentsList.sort(by: {$0.commentDate > $1.commentDate})
                    self.commentTableView.reloadData()
                }
            }
        }
    }
    
    func validateFields() -> String? {
        
        if commentTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            alertMSG.warningAlertMessage(_AlertMessage: EMPTY_FIELDS, _viewCFrom: self)
            return EMPTY_FIELDS
        }
        return nil
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: false)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

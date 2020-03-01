//
//  EventBoardExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import Kingfisher


extension EventBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let eventsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eventDetailsVC") as! EventDetailsViewController
        
        let event:EventModel = self.eventList[indexPath.row]
        
        print(event.eventIdentifire)
        
        eventsController.event = event
        
        self.present(eventsController, animated: true, completion: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell")  as! HomeTableViewCell
        
        print(indexPath.row)
        let event:EventModel = self.eventList[indexPath.row]
        
        print(event.eventIdentifire)
        
        cell.setEvent(event: event)
        
        cell.currentCell = self.eventList
        
        cell.delegate = self
        
        return cell
        
    }
    
    func callSegueFromCell(data dataobject: EventModel, cellForRowAt indexPath: IndexPath) {
        
        let event:EventModel = self.eventList[indexPath.row]
        
        let viewName = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileVC") as! PublisherViewController
        
        viewName.setUser(event: event)
        
        
        self.present(viewName, animated: true, completion: nil)
    }
    
    func transToProfile()  {
        let Trans = TransitionController()
        Trans.trancVC(_viewCIdentifire: "UserProfileVC", _viewCFrom: self)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
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

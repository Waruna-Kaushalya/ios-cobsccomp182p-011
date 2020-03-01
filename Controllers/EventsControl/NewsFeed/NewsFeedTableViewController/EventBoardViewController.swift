//
//  EventBoardViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/18/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import Kingfisher


protocol CellDelegator {
    func callSegueFromCell(data dataobject: EventModel,  cellForRowAt indexPath: IndexPath)
}

class EventBoardViewController: UIViewController, CellDelegator,UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventList:[EventModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveEvents()
        self.tableView.reloadData()
        
        
    }
}




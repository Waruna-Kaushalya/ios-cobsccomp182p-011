//
//  AddEventViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/14/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventImage: UIStackView!
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setElement()

    
    }
    func setElement() {
        eventTitle.styleTextField()
        eventDescription.styleTextField()
        publishButton.styleButton()
    }

}

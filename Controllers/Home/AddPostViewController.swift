//
//  AddPostViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/11/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {
    @IBOutlet weak var butttonClick: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupElement()  {
        ButtonUtilities.ButtonRadius_All(butttonClick)
        ButtonUtilities.styleButton(butttonClick)
    }
}

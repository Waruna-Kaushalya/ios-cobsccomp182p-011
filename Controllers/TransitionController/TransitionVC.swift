//
//  TransitionVC.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/8/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

import UIKit
import Foundation

public class TransitionVC {
    
    public func trancVC(_viewCIdentifire : String, _viewCFrom:UIViewController) {
        
        let viewName = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: _viewCIdentifire)
        
        _viewCFrom.present(viewName, animated: true, completion: nil)
        
    }
}

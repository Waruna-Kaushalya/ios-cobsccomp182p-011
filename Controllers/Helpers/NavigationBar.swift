//
//  NavigationBar.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/9/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

class NavigationBAr {
    
    func viewWillAppear(_ animated: Bool,_naviaBar:UINavigationController) {
//        viewWillAppear(animated, _naviaBar: <#UINavigationController#>)
        _naviaBar.setNavigationBarHidden(true, animated: animated)
    }
    
//     func viewWillDisappear(_ animated: Bool) {
//        viewWillDisappear(animated)
//        UINavigationController?.setNavigationBarHidden(false, animated: animated)
//    }
}



//
//  UIImageUtilities.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/13/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundedImage()  {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}

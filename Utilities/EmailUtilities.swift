//
//  EmailUtilities.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/11/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

class EmailUtilities {
    static func validateEmail(_ candidate: String) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}



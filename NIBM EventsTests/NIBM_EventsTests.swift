//
//  NIBM_EventsTests.swift
//  NIBM EventsTests
//
//  Created by Waruna Kaushalya on 2/4/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import XCTest
@testable import NIBM_Events

class NIBM_EventsTests: XCTestCase {

    
    func testUserLoginStatus(){
        let instence =  CheckUserLoginStatus()
        XCTAssertTrue(instence.checkUserLoginStatus())
    }

    func testUserNotLoginStatus(){
        let instence =  CheckUserLoginStatus()
        XCTAssertFalse(instence.checkUserLoginStatus())
     }
    
}





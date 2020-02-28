//
//  NIBM_EventsUITests.swift
//  NIBM EventsUITests
//
//  Created by Waruna Kaushalya on 2/4/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import XCTest

class NIBM_EventsUITests: XCTestCase {
    
    override func setUp() {
        
        continueAfterFailure = false
        
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        
    }
    
    
    func testUserLogin(){
        
        
        let app = XCUIApplication()
        let myProfileButton = app.tabBars.buttons["My Profile"]
        myProfileButton.tap()
        app.alerts["User not login"].buttons["OK"].tap()
        
        app.textFields["Email Address"].tap()
        
        let wKey = app/*@START_MENU_TOKEN@*/.keys["w"]/*[[".keyboards.keys[\"w\"]",".keys[\"w\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let uKey = app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let key = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let moreKey2 = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, letters\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let mKey = app.keys["m"]
        let kKey = app.keys["k"]
        let key2 = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let key3 = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let qKey = app/*@START_MENU_TOKEN@*/.keys["q"]/*[[".keyboards.keys[\"q\"]",".keys[\"q\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let zKey = app/*@START_MENU_TOKEN@*/.keys["z"]/*[[".keyboards.keys[\"z\"]",".keys[\"z\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let shiftButton = app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let wKey2 = app/*@START_MENU_TOKEN@*/.keys["W"]/*[[".keyboards.keys[\"W\"]",".keys[\"W\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let sKey = app/*@START_MENU_TOKEN@*/.keys["S"]/*[[".keyboards.keys[\"S\"]",".keys[\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let xKey = app/*@START_MENU_TOKEN@*/.keys["X"]/*[[".keyboards.keys[\"X\"]",".keys[\"X\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        wKey.tap()
        
        aKey.tap()
        
        rKey.tap()
        
        uKey.tap()
        
        nKey.tap()
        
        aKey.tap()
        
        moreKey.tap()
        
        key.tap()
        
        moreKey2.tap()
        
        wKey.tap()
        
        mKey.tap()
        
        wKey.tap()
        
        kKey.tap()
        
        moreKey.tap()
        
        key2.tap()
        
        moreKey2.tap()
        
        gKey.tap()
        
        mKey.tap()
        
        aKey.tap()
        
        iKey.tap()
        
        lKey.tap()
        
        moreKey.tap()
        
        key.tap()
        
        moreKey2.tap()
        
        cKey.tap()
        
        oKey.tap()
        
        mKey.tap()
        
        app.secureTextFields["Password"].tap()
        
        moreKey2.tap()
        
        key3.tap()
        
        moreKey2.tap()
        
        qKey.tap()
        
        aKey.tap()
        
        zKey.tap()
        
        moreKey.tap()
        
        key2.tap()
        
        moreKey2.tap()
        
        shiftButton.tap()
        
        wKey2.tap()
        
        shiftButton.tap()
        
        sKey.tap()
        
        shiftButton.tap()
        
        xKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Login"].tap()
        myProfileButton.tap()
        XCUIApplication().tabBars.buttons["My Profile"].tap()
    }
    
    func testUserComment() {
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"27/Feb/2020 23:01")/*[[".cells.containing(.staticText, identifier:\"ff\")",".cells.containing(.staticText, identifier:\"waruna\")",".cells.containing(.staticText, identifier:\"1\")",".cells.containing(.staticText, identifier:\"df\")",".cells.containing(.staticText, identifier:\"27\/Feb\/2020 23:01\")"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Comment"].tap()
        
        let wKey = app/*@START_MENU_TOKEN@*/.keys["w"]/*[[".keyboards.keys[\"w\"]",".keys[\"w\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        wKey.tap()
        wKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        dKey.tap()
        
        elementsQuery.buttons["Post"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.buttons["Close"].tap()
        
    }
}

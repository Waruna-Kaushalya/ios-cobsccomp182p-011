//
//  HomeViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/10/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buttontest: UIButton!
    @IBOutlet weak var testUifield: UITextField!
    
    
//     var videos: [Video] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         videos = createArray()
        setElements()
        
        
    }
//    func createArray() -> [Video] {
//        
//        let video1 = Video(image: #imageLiteral(resourceName: "tropical-leaves-colorful-flower-dark-tropical-foliage-nature-background-dark-green-foliage_34998-128"), title: "Your a app")
//        let video2 = Video(image: #imageLiteral(resourceName: "addImage"), title: "Your b app")
////        let video3 = Video(image: #imageLiteral(resourceName: "f"), title: "Your c app")
////        let video4 = Video(image: #imageLiteral(resourceName: "b"), title: "Your d app")
////        let video5 = Video(image: #imageLiteral(resourceName: "g"), title: "Your e app")
////        let video6 = Video(image: #imageLiteral(resourceName: "b"), title: "Your f app")
//        
//        
//        
//        return [video1,video2]
//        
//    }
    
    @IBAction func checkUserIsLogin(_ sender: Any) {
        let trans = TransitionController()
        
        let  aa = CheckUserLoginStatus()
//        print("AAAAAA")
//        print(aa.checkUserLoginStatus())
//        print("AAAAAA")
        
        if aa.checkUserLoginStatus() == true {
            trans.trancVC(_viewCIdentifire: "AddPostVC", _viewCFrom: self)
        }else{
            let alert = AlertMessages()
            alert.ActionAlert(_title: "User not login", _message: "User must login to add event", _viewCIdentifier: "LoginNavIVC", _viewControllerName: self)
        }
        
    }
    
    func setElements(){
        buttontest.styleButton()
        buttontest.buttonRadiusAll()
        testUifield.styleTextField()
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        let signOut = SignOutAction()
        signOut.signOutAction(_viewIdentifier: "LoginNavIVC", _viewC: self)
    }
    
}




//extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return videos.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let video = videos[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell")  as! HomeTableViewCell
//
//
//        cell.setVideo(video: video)
//
//        return cell
//
//    }
//}

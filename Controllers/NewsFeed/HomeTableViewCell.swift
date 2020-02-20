//
//  HomeTableViewCell.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/19/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    
    func setVideo(video: Video)  {

            let url = URL(string: video.iamage ?? "")
            print("[[[[[[[[[[[[[[[[[[sdvsvsvsdvsd]]]]]]]]]]]]]]]]]]")
            print(url ?? "")
            
            self.postImageView.kf.setImage(with: url)

        postTitle.text = video.title
    }
    
}

//
//  TweetCell.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/27/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var rtCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var rtButton: UIButton!
    
    var rtClicked = false;
    var favClicked = false;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profPic.layer.cornerRadius = 6
        profPic.clipsToBounds = true;
        username.preferredMaxLayoutWidth = username.frame.size.width

        // Initialization code
    }

    @IBAction func clickFav(_ sender: Any) {
        if (favClicked == false){
            let pressed = UIImage(named: "favor-icon-red")
            favButton.setImage(pressed, for: UIControlState.normal)
            favCount.text = "\(Int(favCount.text!)! + 1)"
            favClicked = true;
        }
        else {
            let pressed = UIImage(named: "favor-icon")
            favButton.setImage(pressed, for: UIControlState.normal)
            favCount.text = "\(Int(favCount.text!)! - 1)"
            favClicked = false;
            
        }
    }
    
    @IBAction func clickRT(_ sender: Any) {
        if (rtClicked == false) {
            let rt = UIImage(named: "retweet-icon-green")
            rtButton.setImage(rt, for: UIControlState.normal)
            rtCount.text = "\(Int(rtCount.text!)! + 1)"
            rtClicked = true;
        }
        else{
            let rt = UIImage(named: "retweet-icon")
            rtButton.setImage(rt, for: UIControlState.normal)
            rtCount.text = "\(Int(rtCount.text!)! - 1)"
            rtClicked = false;
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

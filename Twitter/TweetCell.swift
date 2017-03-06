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
    
    var tweet: Tweet?
    
    var twitterClient = TwitterClient.sharedInstance

    
    override func awakeFromNib() {
        super.awakeFromNib()
        profPic.layer.cornerRadius = 6
        profPic.clipsToBounds = true;
        username.preferredMaxLayoutWidth = username.frame.size.width

        // Initialization code
    }

    @IBAction func clickFav(_ sender: Any) {
        if (tweet?.favorited == false){
            let pressed = UIImage(named: "favor-icon-red")
            favButton.setImage(pressed, for: UIControlState.normal)
            tweet?.favoritesCount+=1;
            favCount.text = "\(Int(favCount.text!)! + 1)"
            tweet?.favorited = true;
        }
        else {
            let pressed = UIImage(named: "favor-icon")
            favButton.setImage(pressed, for: UIControlState.normal)
            tweet?.favoritesCount-=1;

            favCount.text = "\(Int(favCount.text!)! - 1)"
            tweet?.favorited = false;
            
        }
    }
    
    @IBAction func clickRT(_ sender: Any) {
        
        twitterClient?.retweet(tweet: self.tweet!, success: {
        }, failure: { (error: Error?) in
            print(error?.localizedDescription as Any)
        })
        
        
        if (tweet?.retweeted == false) {
            let rt = UIImage(named: "retweet-icon-green")
            rtButton.setImage(rt, for: UIControlState.normal)
            tweet?.retweetCount+=1;

            rtCount.text = "\(Int(rtCount.text!)! + 1)"
            tweet?.retweeted = true;
        }
        else{
            let rt = UIImage(named: "retweet-icon")
            rtButton.setImage(rt, for: UIControlState.normal)
            tweet?.retweetCount-=1;
            rtCount.text = "\(Int(rtCount.text!)! - 1)"
            tweet?.retweeted = false;
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.favButton.setImage(UIImage(named: "favor-icon"), for:UIControlState.normal)
        self.rtButton.setImage(UIImage(named: "retweet-icon"), for:UIControlState.normal)
        self.favCount.text = "\(tweet?.favoritesCount)"
        self.rtCount.text = "\(tweet?.retweetCount)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

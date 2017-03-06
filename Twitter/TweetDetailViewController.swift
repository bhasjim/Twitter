//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/28/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

protocol buttonDelegate: class {
    func updateFav()
    func updateRT()
}

class TweetDetailViewController: UIViewController {
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var rtButton: UIButton!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var rtCount: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    var tweet: Tweet!
    var composeDelegate: ComposeVCDelegate?
    var twitterClient = TwitterClient.sharedInstance
    var buttonDelegate: buttonDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        //============ TEXT ============
        self.username.text = "@" + (tweet.account?.username as String?)!
        self.tweetContent.text = tweet.text as String?
        self.name.text = tweet.account?.name as String?
        self.favCount.text = "\(tweet.favoritesCount)"
        self.rtCount.text = "\(tweet.retweetCount)"
        
        
        //============ FAV BUTTON AND RT
        if(tweet.favorited)!{
            self.favButton.setImage(UIImage(named: "favor-icon-red" ), for:UIControlState.normal)
        } else {
            self.favButton.setImage(UIImage(named: "favor-icon" ), for:UIControlState.normal)
        }
        
        if(tweet.retweeted)!{
            self.rtButton.setImage(UIImage(named: "retweet-icon-green"), for:UIControlState.normal)
        } else {
            self.rtButton.setImage(UIImage(named: "retweet-icon"), for:UIControlState.normal)
        }
        

        
        //=========== TIMESTAMP ===========
        let index = tweet.timestamp?.description.index((tweet.timestamp?.description.startIndex)!, offsetBy: 10)
        self.timestamp.text = tweet.timestamp?.description.substring(to: index!)

        //============= PROF PIC ==============
        self.profPic.setImageWith(tweet.account?.profileUrl as! URL)
        profPic.layer.cornerRadius = 6
        profPic.clipsToBounds = true;


        // Do any additional setup after loading the view.
    }
    @IBAction func onRetweetClick(_ sender: Any) {
    
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
        self.buttonDelegate?.updateRT()
    }
    
    @IBAction func onFavClick(_ sender: Any) {
        
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
        self.buttonDelegate?.updateFav()
    }
    
    @IBAction func replyClick(_ sender: Any) {
        self.performSegue(withIdentifier: "toReply", sender: sender)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "toReply") {
            let composeDestination = segue.destination as! ComposeVC
            composeDestination.inReply = tweet;
            composeDestination.composeDelegate = self.composeDelegate
        }
    }

}

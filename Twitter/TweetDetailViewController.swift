//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/28/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        //============ TEXT ============
        self.username.text = tweet.account?.username as String?
        self.tweetContent.text = tweet.text as String?
        self.name.text = tweet.account?.name as String?
        self.favCount.text = "\(tweet.favoritesCount)"
        self.rtCount.text = "\(tweet.retweetCount)"
        tweetContent.sizeToFit()
        tweetContent.numberOfLines = 0;
        
        //=========== TIMESTAMP ===========
        let index = tweet.timestamp?.description.index((tweet.timestamp?.description.startIndex)!, offsetBy: 10)
        self.timestamp.text = tweet.timestamp?.description.substring(to: index!)

        //============= PROF PIC ==============
        self.profPic.setImageWith(tweet.account?.profileUrl as! URL)


        // Do any additional setup after loading the view.
    }
    @IBAction func onRetweetClick(_ sender: Any) {
    }
    
    @IBAction func onFavClick(_ sender: Any) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ProfileVC.swift
//  Twitter
//
//  Created by Nick Hasjim on 3/1/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bannerPhoto: UIImageView!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    
    @IBOutlet weak var tweetTable: UITableView!
    
    var tweets: [Tweet]!
    var account: User?
    
    var composeDelegate: ComposeVCDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationItem.
        username.text = "@" + (account?.username as String?)!;
        name.text = account?.name as String?;
        
        self.profPic.setImageWith(account?.profileUrl as! URL)
        profPic.layer.cornerRadius = 6
        profPic.clipsToBounds = true;

        if(account?.bannerUrl != nil){
            self.bannerPhoto.setImageWith(account?.bannerUrl as! URL)
            blur(sender:bannerPhoto);
        } else {
            
        }
        
        //set constraints so that the image is actually those boundaries, else it's just outside the frame
        self.bannerPhoto.clipsToBounds = true;
        
        
        self.numFollowers.text = "\((account?.followerCount)!)"
        self.numFollowing.text = "\((account?.followingCount)!)"
        self.numTweets.text = "\((account?.numTweets)!)"


//        //Getting all the user's tweets
//        TwitterClient.sharedInstance?.getUserTweets(account!, success: { (tweets: [Tweet]) in
//                self.tweets = tweets
//                print(self.tweets.count)
//                self.tweetTable.reloadData()
//
//            
//        }, failure: { (error:Error?) in
//            print(error?.localizedDescription)
//        })
        
        self.tweetTable.reloadData()
        
        
    }
    
    
    
    
    //==================== BLURRRR
    //==================== BLURRRR
    func blur (sender: UIImageView){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.3
        blurEffectView.frame = sender.bounds
        sender.addSubview(blurEffectView)
        
        blurEffectView.alpha = 0 //makes blur completely clear
        UIView.animate(withDuration: 0.8) { //slowly builds blur back up
            blurEffectView.alpha = 0.8
        }
        
    }
    
    
    @IBAction func onComposeClick(_ sender: Any) {
        self.performSegue(withIdentifier: "toComposeTweet", sender: sender)
    }
    
    
    

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count;
        } else {
            return 0
        }
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTable.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = tweets[indexPath.row]
        
        cell.username.text = tweet.account?.username as String?
        
        let index = tweet.timestamp?.description.index((tweet.timestamp?.description.startIndex)!, offsetBy: 10)
        cell.time.text = tweet.timestamp?.description.substring(to: index!)
        cell.favCount.text = "\(tweet.favoritesCount)"
        cell.profPic.setImageWith(tweet.account?.profileUrl as! URL)
        cell.tweetText.text = tweet.text as String?
        cell.rtCount.text = "\(tweet.retweetCount)"
        
        
//        // =========== ADDING TAP TO PROF PIC ===========
//        cell.profPic?.isUserInteractionEnabled = true
//        cell.profPic?.tag = indexPath.row //saves the index
//        let tapped = UITapGestureRecognizer(target: self, action: #selector(self.TappedOnImage(recognizer:))) //clicks on image and does function
//        tapped.numberOfTapsRequired = 1
//        tapped.numberOfTouchesRequired = 1
//        cell.profPic?.addGestureRecognizer(tapped)
        
        return cell
        
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
        
        //setting compose delegate
        if(segue.identifier == "toComposeTweet"){
            let composeVC = segue.destination as! ComposeVC
            composeVC.composeDelegate = self.composeDelegate
        }
        
        
    }

}

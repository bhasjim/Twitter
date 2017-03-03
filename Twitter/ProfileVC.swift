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

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationItem.
        username.text = account?.username as String?;
        name.text = account?.name as String?;
        
        self.profPic.setImageWith(account?.profileUrl as! URL)
        profPic.layer.cornerRadius = 6
        profPic.clipsToBounds = true;

        self.bannerPhoto.setImageWith(account?.bannerUrl as! URL)
        blur(sender:bannerPhoto);
        
        //set constraints so that the image is actually those boundaries, else it's just outside the frame
        self.bannerPhoto.clipsToBounds = true;
        
        
        self.numFollowers.text = "\((account?.followerCount)!)"
        self.numFollowing.text = "\((account?.followingCount)!)"
        self.numTweets.text = "\((account?.numTweets)!)"

        
        
        //=============== GETTING TWEEEEETS
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetTable.reloadData()
            
        }) { (error: NSError) -> () in
            print(error.localizedDescription)
        }
        
        self.tweetTable.reloadData()

        
        

        // Do any additional setup after loading the view.
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
    
    
    @IBAction func prepare(forUnwind segue: UIStoryboardSegue) {
        
    }
    

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init();
        return cell;
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

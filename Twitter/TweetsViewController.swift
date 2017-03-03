//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/24/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    
    @IBOutlet weak var TableView: UITableView!
    var tweets: [Tweet]!
    var isMoreDataLoading = false


    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate=self
        TableView.dataSource=self
        
        getTweets()
        
        self.TableView.reloadData()
    }
    
    func getTweets() {
        //Getting all the home tweets
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.TableView.reloadData()
            
        }) { (error: NSError) -> () in
            print(error.localizedDescription)
        }
        
        self.TableView.reloadData()
        
    }
    
    
    // ============= MAKE NAV BAR GREAT AGAIN
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.25, green:0.60, blue:1.00, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count;
        } else {
            return 0
        }
    }
    
    
    // ====================== SEND TO PROFILE VC
    /*
      If you click on the prof pic then send it to the profile view controller!!
     */
    func TappedOnImage(recognizer:UITapGestureRecognizer){
        guard let imageView = recognizer.view as? UIImageView
            else {return}
        print(imageView.tag)
        self.performSegue(withIdentifier: "toProfileVC", sender: recognizer)
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = tweets[indexPath.row]
        
        cell.username.text = tweet.account?.username as String?
        
        let index = tweet.timestamp?.description.index((tweet.timestamp?.description.startIndex)!, offsetBy: 10)
        cell.time.text = tweet.timestamp?.description.substring(to: index!)
        cell.favCount.text = "\(tweet.favoritesCount)"
        cell.profPic.setImageWith(tweet.account?.profileUrl as! URL)
        cell.tweetText.text = tweet.text as String?
        cell.rtCount.text = "\(tweet.retweetCount)"
        
        
        // =========== ADDING TAP TO PROF PIC ===========
        cell.profPic?.isUserInteractionEnabled = true
        cell.profPic?.tag = indexPath.row //saves the index
        let tapped = UITapGestureRecognizer(target: self, action: #selector(self.TappedOnImage(recognizer:))) //clicks on image and does function
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        cell.profPic?.addGestureRecognizer(tapped)
        
        return cell
        
    }
    
    @IBAction func onTweetCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "tweetsToCompose", sender: sender)
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
        
        //===============going to ProfileVC
        //===============going to ProfileVC
        if segue.identifier == "toProfileVC" { //if it is segue to profile then go to profileVC
            
            let newSender = sender as? UITapGestureRecognizer //cast it so we can get .view
            let image = newSender?.view; //getting the image
            
            let index = (image?.tag)! as Int; //get the tag aka the index
            let tweet = self.tweets![index] //get specific tweet from array of tweets
            
            let profileVC = segue.destination as! ProfileVC //profileVC
            profileVC.account = tweet.account; //set account to the account we want
            profileVC.composeDelegate = self; //setting the delegate in case we tweet from there
            
        }
        
        //===============going to detailsVC
        //===============going to detailsVC
        if segue.identifier == "showTweetDetails" {
        
            let cell = sender as! UITableViewCell //click on the cell so it is a sender
            let indexPath = TableView.indexPath(for: cell); //indexpath of the cell
            let tweet = self.tweets![indexPath!.row] //get the contents of the cell (tweet)
        
            let tweetDetails = segue.destination as! TweetDetailViewController
            tweetDetails.tweet = tweet;
            tweetDetails.composeDelegate = self
        }
        
        //=============== going to composeVC
        //=============== going to composeVC
        if segue.identifier == "tweetsToCompose" {
            let destination = segue.destination as! ComposeVC
            destination.composeDelegate = self;
        }
    }
 

}


extension TweetsViewController: ComposeVCDelegate{
    func uploadTweet(tweet: Tweet) {
        getTweets() //basically calling the home_timeline to update our home_Timeline
        TableView.reloadData() //reload so it shows!
    }
    
}


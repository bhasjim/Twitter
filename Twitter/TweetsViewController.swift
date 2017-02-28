//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/24/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var TableView: UITableView!
    var tweets: [Tweet]!

    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate=self
        TableView.dataSource=self
        
        //Getting all the home tweets
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.TableView.reloadData()
            
        }) { (error: NSError) -> () in
            print(error.localizedDescription)
        }
        
        self.TableView.reloadData()
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
        let cell = TableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = tweets[indexPath.row]
        
        cell.username.text = tweet.account?.username as String?
        cell.time.text = tweet.timestamp?.description
        cell.favCount.text = "\(tweet.favoritesCount)"
        cell.profPic.setImageWith(tweet.account?.profileUrl as! URL)
        cell.tweetText.text = tweet.text as String?
        cell.rtCount.text = "\(tweet.retweetCount)"
        return cell
        
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

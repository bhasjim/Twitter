//
//  TwitterClient.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/24/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    

    //because TwitterClient is BDBOAuth1SessionManager
    static let sharedInstance = TwitterClient (baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "qD4k4zqpmv2QaHOzh4e2VDmcL", consumerSecret: "0EDrAWIadwJzBXWQt44rgGDv5XXAEt96iehnECJHMuHd6gGDRO")
    
    var loginSuccess: (() ->())?
    var loginFailure: ((NSError)->())?
    
    func homeTimeline(success: @escaping ([Tweet])->(), failure: @escaping (NSError) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: ["count": 30], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let dictionaries = response as! [NSDictionary] //tweets is an array
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
            
        })
    }
    
    //========== GETTING USER TIMELINE
    //========== GETTING USER TIMELINE
    //========== GETTING USER TIMELINE
    func userTimeline(id:Int ,success: @escaping ([Tweet])->(), failure: @escaping (NSError) -> ()){
        
        get("1.1/statuses/user_timeline", parameters: ["user_id":"\(id)","count": 30], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary] //tweets is an array
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
            
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            //prints full account
            //print("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error as NSError)
        })
        
    }
    
    func login(success: @escaping ()->(), failure: @escaping (NSError)->()){
        self.loginSuccess = success
        self.loginFailure = failure
        
        
        TwitterClient.sharedInstance?.deauthorize()
    
        //token is permission to send user to the authorized URL
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "/oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void  in
            print("I got a token!")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
            print(("https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token)"))
            print("\(requestToken?.token)")
            UIApplication.shared.open(url as URL)
            
        }) { (error: Error?) -> Void in
            print("Error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError) //passes along failure
        }
    }
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
        
    }
    
    func handleOpenUrl(url: NSURL) {
        //gets the Twitter Client so we can make API calls on behalf of this user
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            print("I got access token")
            // actually gets twitter account now
            
            self.currentAccount(success: { (user:User)->() in
                User.currentUser = user //sets the user
                self.loginSuccess?();
                
                
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error);
            })
            self.loginSuccess?()
            
            
            
//            client?.homeTimeline(success: { (tweets: [Tweet]) -> () in
//                for tweet in tweets {
//                    print(tweet.text)
//                }
//            }, failure: { (error: NSError) -> () in
//                print(error.localizedDescription)
//            })
//            
//            
//            client?.currentAccount()
//            
//
//            
            
            
        }, failure: { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })

        
    }
}

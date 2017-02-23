
//
//  LoginViewController.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/23/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "qD4k4zqpmv2QaHOzh4e2VDmcL", consumerSecret: "0EDrAWIadwJzBXWQt44rgGDv5XXAEt96iehnECJHMuHd6gGDRO")
        
        twitterClient?.deauthorize()
        
        
        
        //token is permission to send user to the authorized URL
        twitterClient?.fetchRequestToken(withPath: "/oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void  in
            print("I got a token!")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
            print(("https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token)"))
            print("\(requestToken?.token)")
            UIApplication.shared.open(url as URL)

        }) { (error: Error?) -> Void in
            print("Error: \(error?.localizedDescription)")
        }
        
        
        
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


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

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 6
        loginButton.layer.borderWidth = 2;
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.clipsToBounds = true;


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLoginButton(_ sender: Any) {
        
        let client = TwitterClient.sharedInstance
        client?.login(success: { () ->() in
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            print("I've logged in")
        }) { (error: NSError) -> () in
            print("Error: \(error.localizedDescription)")
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

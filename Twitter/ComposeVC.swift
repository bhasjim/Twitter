//
//  ComposeVC.swift
//  Twitter
//
//  Created by Nick Hasjim on 3/2/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

protocol ComposeVCDelegate: class {
    func uploadTweet(tweet: Tweet)
}

class ComposeVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var inReply: Tweet?
    var composeDelegate: ComposeVCDelegate?
    
    
    //-=============== VIEW DID LOAD ===============-
    //-=============== VIEW DID LOAD ===============-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.delegate = self;

        
        //tweetText!.layer.borderWidth = 1
        tweetText.layer.cornerRadius = 6;
        tweetText.clipsToBounds = true;
        
        if(inReply != nil) {
            tweetText.text = "@" + "\(inReply?.account?.username as! String) ";
            tweetText.textColor = UIColor.black
        }
        else{
            tweetText.text = "What's happening?"
            tweetText.textColor = UIColor.lightGray
        }
        
        self.username.text = User.currentUser?.username as String?
        self.name.text = User.currentUser?.name as String?
        self.profPic.setImageWith(User.currentUser?.profileUrl as! URL)
        self.profPic.layer.cornerRadius = 6;
        self.profPic.clipsToBounds = true;

        

        // Do any additional setup after loading the view.
    }
    
    
    //============= MAKE NAV BAR GREAT AGAIN
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navBar.barTintColor = UIColor(red:0.25, green:0.60, blue:1.00, alpha:1.0)
        self.navBar.tintColor = UIColor.white
        self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        
        //tweetText.becomeFirstResponder()

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray
        }
        else{
            textView.resignFirstResponder()
        }
    }

    @IBAction func onTweetClick(_ sender: Any) {
        
        
        TwitterClient.sharedInstance?.tweetWithText(self.tweetText.text, inReplyToTweet: self.inReply, success: { (tweet: Tweet) in
            
            //self.delegate?.ComposeTweetViewController(self, willExitWithSuccessfulTweet: tweet)
            self.tweetText.resignFirstResponder()
            self.composeDelegate?.uploadTweet(tweet: tweet) //using our outside variable

            self.dismiss(animated: true, completion: nil)
            
        }) { (error: Error?) in
            print(error?.localizedDescription as Any)
        }
        tweetText.resignFirstResponder()
        


    }
    
    
    @IBAction func onCancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    //=============== IF USER CLICKS OUTSIDE OF TEXTBOX, END EDITING
    //=============== IF USER CLICKS OUTSIDE OF TEXTBOX, END EDITING
    //=============== IF USER CLICKS OUTSIDE OF TEXTBOX, END EDITING
    //=============== IF USER CLICKS OUTSIDE OF TEXTBOX, END EDITING
    @IBAction func doneEditing(_ sender: Any) {
        tweetText.resignFirstResponder()
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

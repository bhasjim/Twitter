//
//  ComposeVC.swift
//  Twitter
//
//  Created by Nick Hasjim on 3/2/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

class ComposeVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    //-=============== VIEW DID LOAD ===============-
    //-=============== VIEW DID LOAD ===============-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.delegate = self;
        
        //tweetText!.layer.borderWidth = 1
        tweetText.layer.cornerRadius = 6;
        tweetText.clipsToBounds = true;
        tweetText.text = "What's happening?"
        tweetText.textColor = UIColor.lightGray
        tweetText.selectedTextRange = tweetText.textRange(from: tweetText.beginningOfDocument, to: tweetText.beginningOfDocument)

        
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
        
        tweetText.becomeFirstResponder()

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
    }
    
    
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText = textView.text
        let nsText = currentText as NSString?
        let updatedText = nsText?.replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if (updatedText?.isEmpty)! {
            
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    
    
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
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

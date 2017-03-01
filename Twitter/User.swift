//
//  User.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/23/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var username: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        //deserialization code. Takes dictionary and populating individual properties
        //models take care of serialization (other way) and persistence
        self.dictionary = dictionary
        
        
        name = dictionary["name"] as? String as NSString? //attempt to cast to String, if not there it is nil
        username = dictionary["screen_name"] as? NSString
        tagline = dictionary["description"] as? NSString
        
        //================ PROFILE IMAGE
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        let normalSized = profileUrlString?.replacingOccurrences(of: "_normal.", with: ".", options: .literal, range: nil)
        if let normalSized = normalSized {
            profileUrl = NSURL(string: normalSized);
            
        }
    }
    static var userDidLogoutNotification = "UserDidLogout"

    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard;
                let userData = defaults.object(forKey: "currentUser") as? NSData
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set (user){
            _currentUser = user
            let defaults = UserDefaults.standard;

            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUser")

            } else {
                defaults.set(nil, forKey: "currentUser")

            }
            defaults.synchronize()
            

        }
    }
    

}

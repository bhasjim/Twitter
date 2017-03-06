//
//  Tweet.swift
//  Twitter
//
//  Created by Nick Hasjim on 2/23/17.
//  Copyright © 2017 Nick Hasjim. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var account: User?
    var id: String?
    var favorited: Bool?
    var retweeted: Bool?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        account = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        id = dictionary["id_str"] as? String
        
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool

        
        
        //for time
        let timeStampString = dictionary["created_at"] as? NSString
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"

            let dateObj = formatter.date(from: timeStampString as String) as NSDate?
            
            let deformatter = DateFormatter()
            deformatter.dateFormat = "MM-dd-yyyy"
            let timeString = deformatter.string(from: dateObj as! Date)
            
            timestamp = deformatter.date(from: timeString as String) as NSDate?
        }
    }
    
    //class function. Like static
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]() //swift style empty array
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets;
    
    }

}

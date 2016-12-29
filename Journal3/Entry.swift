//
//  File.swift
//  Journal3
//
//  Created by Chandi Abey  on 8/19/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

//make the class conform to the Equatable protocol. This accomplishes two things- gives us access to the correct indexOf function and useful for persistence through NSUserDefaults 
//QUESTION: How is the equatable protocol a prerequistie for the use of NSUserDefaults? 

class Entry: Equatable {
    
    //variables for keys to be used in the computed properties and failable initializers below. It does not matter what you put in the string.
    fileprivate let kTitle = "titleKey"
    fileprivate let kBodyText = "bodyTextKey"
    fileprivate let kTimeStamp = "timeStampKey"
    
    
    //three properties needed to create a simple journal app
    var title: String
    var bodyText: String
    var timeStamp: Date = Date()
    
    
    //initialize the two variables above. 
    //QUESTION: Should timestamp be a variable since it may need to be updated when we edit an entry and repost?
    init(title: String, bodyText: String) {
        //setting the class's properties defined above to the initialized values of the initializer
        self.title = title
        self.bodyText = bodyText

    }

  
    //create a computed property to convert Entry type to dictionary type when we want to save data using NSUserDefaults
    //define a private let key above so we avoid errors from using strings for keys
    var dictionaryRepresentation: [String: AnyObject] {
        return [kTitle: title as AnyObject, kBodyText: bodyText as AnyObject, kTimeStamp: timeStamp as AnyObject]
    }
    
    //CODE LOOKUP: Guard statement dictionary[key], key is how we retrieve the value, we dont know the value itself so just remember the format dictionaryy[DEFINED KEY]
    init?(dictionary: [String: AnyObject]) {
        guard let
                  title = dictionary[kTitle] as? String,
                  let bodyText = dictionary[kBodyText] as? String,
                  let timeStamp = dictionary[kTimeStamp] as? Date
        
        else { return nil }
        
        self.title = title
        self.bodyText = bodyText
        self.timeStamp = timeStamp
        
        
    }
    
    
}

//create an equatable protocol
func ==(lhs: Entry, rhs: Entry) -> Bool {
    return lhs.title == rhs.title && lhs.bodyText == rhs.bodyText && lhs.timeStamp == rhs.timeStamp

}

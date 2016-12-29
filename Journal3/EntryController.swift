//
//  EntryController.swift
//  Journal3
//
//  Created by Chandi Abey  on 8/19/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class EntryController {
    
    //create a singleton instance of this EntryController. This is where the array that holds our data will reside.
    //NOTE TO SELF: Read articles on singletons
    static let sharedController = EntryController()
    
    
    //private keys to use for the storing and loading in NSUserDefaults
    fileprivate let kStoredEntries = "storedEntries"
    
    
    
    //also define an array where we will store the journal entries. we can first create a 
    var entries: [Entry] = []
    
    //initialize using loadDataFromPersistentStorage
    init() {
        
    }
    
    
    //think about what functions we need to run the journal app. Create Read Update Delete. Each of these processes will take an object of type entry
    //QUESTION FOR MENTOR: Why did we create this separate createEntry function instead of just combining this in an add entry function in the playlist function? Different proejct.

    
    func addEntry(_ entry: Entry) {
        entries.append(entry)
    }
    
    
    func deleteEntry(_ entry: Entry) {
    //to delete an entry, we need to determine where that entry is located and then remove it from the array of entries defined above.
        
        //locating where the index is using the indexOf function on the existing array. Since indexOf returns an optional we make this an if let statements
        if let index = EntryController.sharedController.entries.index(of: entry) {
            //removing the entry from the index
            entries.remove(at: index)
        }
    }
    
    
    //MARK- NSUSERDEFAULTS for saving and loading data. because we are referencing arrays and dictionaries here, create a private store variable above for the entries. The value is going to be in the array
    
    func saveDataToPersistentStorage() {
        UserDefaults.standard.set(entries.map({$0.dictionaryRepresentation}), forKey: kStoredEntries)
        
    }
    
    func loadDataToPersistentStorage() {
        //we are retrieving something so this will be an optional in case it is not there so we will use an if let statement
        //what is it we are retrieving- an array of dictionaries
        //what do we do after we get it? we convert it into a Entry format going through the entire array and add it to the emptry array
        //CODE LOOKUP: Had to cast this as an Entry type
        if let arrayOfDictionaries = UserDefaults.standard.object(forKey: kStoredEntries) as? [[String: AnyObject]] {
            entries = arrayOfDictionaries.flatMap({Entry(dictionary:$0)})

        }
        
    }
    
}

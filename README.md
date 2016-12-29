# Journal-
Simple Journal app to practice MVC separation, protocols, master-detail interfaces, table views, and persistence using NSUserDefaults.  

Takeaways: 
- Create a custom model object (1) with a memberwise intializer (2) conforming to the equatable protocol : Equatable protocol gives the model class a way to find equal objects. Allows you to check for equality between two variables of a specific class. You may use the ObjectIdentifier() function on class types but you may decide to manually check the values of the properties of the class. 
- Create a custom model object controller with create, read, update and delete functions 
- NSCoding protocol on the Entry class
- Implement the UITextFieldDelegate protocol to dismiss the keyboard. This involved adding a UITextField for the entry's title text to the top of the scene, adding an outlet to the class file, setting the delegate relationship, and implementing the delegate function textFieldShouldReturn to resign first responder to dismiss the keyboard 
- Create relationship segues in storyboards: This particular project involved to segues. The segue from the plus button tells the detail VC that it should create a new entry. The segue from the selected tells the detail VC it should display previously created entry and save any changes (capture selected entry using indexpath of selected cell) 
- Understand, use and implement the "updateWith" pattern for updating the view elements with the details of a model object  To follow this pattern, the developer adds an 'updateWith' function that takes a model object. The function updates the view with details from the model object.
- Add persistence using NSUserDefaults *NEW by (1) creating a dictionary representation in the model class and a failable initializer that takes a dictionary as a parameter (2) creating save and loading functions in the model controller where map function is used to translate objects  



MORE ON NSUSERDEFAULTS: 
Because Entry class objects are not plist compatible, and NSUserDefaults will only store classes that are, we have two options:
1. Implement NSCoding to allow native saving and loading from plist objects like NSUserDefaults
2. Add factory functions to make Dictionary representations of the object and initialize new objects with a Dictionary
There are pros and cons to both approaches. We've opted to go with the latter because it is closer to working with network services and APIs. 

MODEL 
1. Write a dictionaryCopy function that returns a Dictionary with keys and values matching the properties of the object.
    * note: Avoid using 'Magic Strings' in your code. Create private string keys for the class for each property that will be stored to and pulled from a Dictionary (ex. private let timeStampKey = "timestamp")
2. Write a failable initializer that takes a Dictionary as a parameter and sets the timestamp, title, and text properties using the values from the dictionary.
    * note: Use guard let to check the optional values in the Dictionary, return nil if any of the properties are missing
    * note: There is a known bug in Swift that requires stored properties to be set even when returning nil from a faillable initializer

MODEL CONTROLLER 
We are now adding a layer of persistent storage, so we need to update our EntryController to load entries from NSUserDefaults on initialization, and save the entries to NSUserDefaults when they are updated.
1. Write a method called saveToPersistentStorage() that will save the current entries array to NSUserDefaults
    * note: Map the entries array to an array of plist compatible dictionary copies
    * note: Avoid 'Magic Strings' when saving to NSUserDefaults
2. Write a method called loadFromPersistentStorage() that will load saved dictionary entries from NSUserDefaults and set self.entries to the results
    * note: Use the Entry init(dictionary: Dictionary) in a Map function to turn the dictionaries into Entry class objects
3. Call the loadFromPersistentStorage() function when the EntryController is initialized
4. Call the saveToPersistentStorage() any time that the list of entries is modified





Future Features
- Add support for multiple journals by adding a journal object that holds entries, a journal list view and displays journals 
- Add support for tags on journals, add functionality to select a tag to display a list of entries with that tag
- Implement the NSCoding protocol on the Entry class

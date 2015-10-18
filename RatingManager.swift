//
//  RatingManager.swift
//
//  Created by TheFlow_ on 18/10/2015.
//  Copyright © 2015 TheFlow_. All rights reserved.
//

import UIKit

class RatingManager {
    private var launchCounter: Int {
        get {
            let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            
            return  NSUserDefaults.standardUserDefaults().objectForKey("LaunchCounter\(version)") as? Int ?? 0
        }
        set {
            let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
            
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "LaunchCounter\(version)")
        }
    }
    
    private var showAlert: Bool {
        get {
            return  NSUserDefaults.standardUserDefaults().objectForKey("ShowAlert") as? Bool ?? true
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "ShowAlert")
        }
    }
    
    private let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String!
    
    /// Controller where to present alert.
    var controller: UIViewController
    
    /// App Store link of your app.
    var appStoreLink: String
    
    /// Show alert each given launch number.
    var period = 5
    
    /// Alert's title.
    var alertTitle: String
    
    /// Alert's message.
    var alertMessage: String
    
    /// Alert's rate button.
    let alertRateButton = "Noter maintenant"
    
    /// Alert's later button.
    let alertLaterButton = "Me le rappeler plus tard"
    
    /// Alert's never button.
    let alertNeverButton = "Ne plus me demander"
    
    /**
    Initializes the RatingManager with the given parameters.
    
    - parameter controller:     Controller where to present alert.
    - parameter link:   App Store link of your app.
    
    - returns: RatingManager instance
    */
    init(controller: UIViewController, link: String) {
        self.controller = controller
        self.appStoreLink = link
        
        self.alertTitle = "Noter \(self.appName)"
        self.alertMessage = "Si vous aimez l'application \(self.appName), prenez le temps de la noter sur l'App Store."
    }
    
    /**
    Call it on App Delegate to prompt the alert on the appropriate time.
    */
    func promptAlert() {
        launchCounter++
        
        if launchCounter%period == 0 && showAlert == true {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            
            let rateAction = UIAlertAction(title: alertRateButton, style: .Cancel, handler: rate)
            let laterAction = UIAlertAction(title: alertLaterButton, style: .Default, handler: nil)
            let neverAction = UIAlertAction(title: alertNeverButton, style: .Default, handler: dontRate)
            
            alert.addAction(rateAction)
            alert.addAction(neverAction)
            alert.addAction(laterAction)
            
            controller.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func rate(action: UIAlertAction) {
        UIApplication.sharedApplication().openURL(NSURL(string: appStoreLink)!)
        showAlert = false
    }
    
    private func dontRate(action: UIAlertAction) {
        showAlert = false
    }
}

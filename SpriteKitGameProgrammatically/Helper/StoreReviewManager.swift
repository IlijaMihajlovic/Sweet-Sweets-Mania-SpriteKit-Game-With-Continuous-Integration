//
//  StoreReviewManager.swift
//  Sweet Sweets Mania
//
//  Created by Ilija Mihajlovic on 5/23/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation
import StoreKit

struct UserDefaultsKey {
    static let APP_OPENED_COUNT = "APP_OPENED_COUNT"
}

struct StoreReviewManger {
    
    //Called from Appdelegate didfinishLaunchingWithOptions method
    static func incrementAppOpenedCount() {
        guard var appOpenCount = kUserDefaults.value(forKey: UserDefaultsKey.APP_OPENED_COUNT) as? Int else {
            kUserDefaults.set(1, forKey: UserDefaultsKey.APP_OPENED_COUNT)
            return
        }
        appOpenCount += 1
        kUserDefaults.set(appOpenCount, forKey: UserDefaultsKey.APP_OPENED_COUNT)
    }
    
    //Called when we want to ask the user to rate our app
    static func checkAndAskForReview() {
        
        //This will not be shown everytime. Apple has some internal logic on how to show this
        guard var appOpenCount = kUserDefaults.value(forKey: UserDefaultsKey.APP_OPENED_COUNT) as? Int else {
            kUserDefaults.set(1, forKey: UserDefaultsKey.APP_OPENED_COUNT)
            return
        }
        
        switch appOpenCount {
        
        //I'm showing the SKStoreReviewController here on the first launch only for presentation purposes
        case 1,2,20,50:
            StoreReviewManger().requestReview()
       
        case _ where appOpenCount%100 == 0 :
            StoreReviewManger().requestReview()
       
        default:
           
            print("App run count is : \(appOpenCount)")
            break;
        }
    }
    
    
    fileprivate func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        
        } else {
            // Fallback on earlier versions
            
        }
    }
}


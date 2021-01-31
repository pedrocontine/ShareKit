//
//  ShareManager.swift
//  ShareKit
//
//  Created by Pedro Contine on 30/01/21.
//

import UIKit

public class ShareView {
    
    public static func present(in viewController: UIViewController,
                               itemsToShare: [Any],
                               removeShareOptions: [UIActivity.ActivityType] = []) {
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = viewController.view // For iPad
        activityVC.excludedActivityTypes = removeShareOptions
        
        viewController.present(activityVC, animated: true, completion: nil)
    }
}

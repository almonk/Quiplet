//
//  SafariExtensionViewController.swift
//  SafariExt
//
//  Created by Alasdair Lampon-Monk on 24/09/2018.
//  Copyright © 2018 Alasdair Lampon-Monk. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}

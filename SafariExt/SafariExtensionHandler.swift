//
//  SafariExtensionHandler.swift
//  SafariExt
//
//  Created by Alasdair Lampon-Monk on 24/09/2018.
//  Copyright © 2018 Alasdair Lampon-Monk. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        window.getActiveTab(completionHandler: {(activeTab) in
            activeTab?.getActivePage(completionHandler:  { (activePage) in
                activePage?.getPropertiesWithCompletionHandler( { (properties) in
                    if properties?.url != nil {
                        let urlString = properties!.url!.absoluteString
                        print("URL!", urlString)
                        let urlArray : [String] = urlString.components(separatedBy: "quip.com")
                        print(urlArray[1])
                        NSWorkspace.shared.open(URL.init(string: "quip:/\(urlArray[1])")!)
                    }
                })
            })
        })
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        window.getActiveTab(completionHandler: {(activeTab) in
            if (activeTab != nil) {
                activeTab?.getActivePage(completionHandler:  { (activePage) in
                    activePage?.getPropertiesWithCompletionHandler( { (properties) in
                        if properties?.url != nil {
                            validationHandler(true, "")
                        } else {
                            validationHandler(false, "")
                        }
                    })
                })
            } else {
                validationHandler(false, "")
            }
        })

    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}

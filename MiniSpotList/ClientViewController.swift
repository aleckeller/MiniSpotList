//
//  SongsViewController.swift
//  MiniSpotList
//
//  Created by Alec Keller on 10/10/17.
//  Copyright © 2017 AKKeller. All rights reserved.
//

import Cocoa
import SpotifyKit

class ClientViewController: NSViewController{
    
    @IBOutlet weak var clientIdText: NSTextField!
    @IBOutlet weak var clientSecretText: NSSecureTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func createSpotifyManager(_ sender: NSButton){
        Vars.spotifyManager = SpotifyManager(with:
            SpotifyManager.SpotifyDeveloperApplication(
                clientId: clientIdText.stringValue,
                clientSecret: clientSecretText.stringValue,
                redirectUri: "minispotlist://callback")
        )
        initEventManager()
        //if already authorized, launch app
        //if the user is not authorized, handleURLEvent will be called and authorize them
        if (Vars.spotifyManager.authorize()){
            print ("Already Authorized")
            Vars.appDelegate.launchPopover()
        }
        
    }
    func initEventManager(){
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(handleURLEvent), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    @objc func handleURLEvent(event: NSAppleEventDescriptor,
                              replyEvent: NSAppleEventDescriptor) {
        if let descriptor = event.paramDescriptor(forKeyword: keyDirectObject),
            let urlString = descriptor.stringValue,
            let url = URL(string: urlString) {
            Vars.spotifyManager.saveToken(from: url)
            print ("authorized")
            Vars.appDelegate.launchPopover()
        }
    }
}

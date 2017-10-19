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
    
    @IBOutlet weak var spotifyImage: NSImageCell!
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
        Vars.spotifyManager.authorize()
        
    }
    func initEventManager(){
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(handleURLEvent), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    @objc func handleURLEvent(event: NSAppleEventDescriptor,
                              replyEvent: NSAppleEventDescriptor) {
        if let descriptor = event.paramDescriptor(forKeyword: keyDirectObject),
            let urlString = descriptor.stringValue,
            let url = URL(string: urlString) {
            Vars.popover.close()
            Vars.spotifyManager.saveToken(from: url)
            Vars.appDelegate.getLibrary()
        }
    }
    @IBAction func quit(_ sender: NSButton) {
        NSApplication.shared.terminate(sender)
    }
}
extension ClientViewController {
    static func freshController() -> ClientViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle:nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "ClientController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ClientViewController else {
            fatalError("Can't find ClientViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

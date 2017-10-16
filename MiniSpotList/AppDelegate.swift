//
//  AppDelegate.swift
//  MiniSpotList
//
//  Created by Alec Keller on 10/6/17.
//  Copyright © 2017 AKKeller. All rights reserved.
//

import Cocoa
import SpotifyKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
    
    func launchPopover(){

        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("music-player"))
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = MiniSpotListViewController.freshController()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.library(SpotifyPlaylist.self)
            //self.myProfile()
        }
        
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        }
        else{
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?){
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?){
        popover.performClose(sender)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func library<T>(_ type: T.Type) where T: SpotifyLibraryItem {
        Vars.spotifyManager.library(type) { result in
            for playlist in result {
                Vars.playlists.append(playlist)
                Vars.trackNames.append(playlist.name)
            }
        }
    }
    func myProfile() {
        Vars.spotifyManager.myProfile() { result in
            print(result)
        }
    }
    func playSong(id: String){
        let spotifyScript = SpotifyScript.getTrack() as! AppleScriptProtocol
        let trackId = NSAppleEventDescriptor(string: id)
        spotifyScript.playTrack(trackId)
    }
    func getCurrentlyPlaying() -> String {
        let spotifyScript = SpotifyScript.getTrack() as! AppleScriptProtocol
        return spotifyScript.getCurrentPlaying() as String
    }
    
}





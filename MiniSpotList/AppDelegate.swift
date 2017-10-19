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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //create button on menu bar
        if let button = Vars.statusItem.button {
            button.image = NSImage(named:NSImage.Name("music-player"))
            button.action = #selector(togglePopover(_:))
        }
        //check if user is already authorized with spotify manager
        //if user is, open up MiniSpotListController
        //if not, open up ClientViewController
        if (Vars.spotifyManager.hasToken && !Vars.spotifyManager.expired){
            print ("Already Authorized and Token is not expired")
            self.library(SpotifyPlaylist.self)
        }
        else{
            print ("Not Authorized")
            Vars.popover.contentViewController = ClientViewController.freshController()
        }
    }
    // Gets the User's Spotify Library and sets the popover to the controller to display playlists
    func library<T>(_ type: T.Type) where T: SpotifyLibraryItem {
        print(Vars.spotifyManager.hasToken)
        Vars.spotifyManager.library(type) { result in
            for playlist in result {
                Vars.playlists.append(playlist)
                Vars.trackNames.append(playlist.name)
            }
        }
        Vars.popover.contentViewController = MiniSpotListViewController.freshController()
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if Vars.popover.isShown {
            closePopover(sender: sender)
        }
        else{
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?){
        if let button = Vars.statusItem.button {
            Vars.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?){
        Vars.popover.performClose(sender)
    }
    
    func myProfile() {
        Vars.spotifyManager.myProfile() { result in
            print(result)
        }
    }
    func playSong(id: String){
        let spotifyScript = SpotifyScript.getTrack() as! AppleScriptProtocol
        let trackId = NSAppleEventDescriptor(string: id)
        let userId = NSAppleEventDescriptor(string: Vars.selectedPlaylistUserId)
        let playlistId = NSAppleEventDescriptor(string: Vars.selectdPlaylistId)
        spotifyScript.playTrack(trackId, userId: userId, playlistId: playlistId)
    }
    func getCurrentlyPlaying() -> String {
        let spotifyScript = SpotifyScript.getTrack() as! AppleScriptProtocol
        return spotifyScript.getCurrentPlaying() as String
    }
    func getLibrary(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.library(SpotifyPlaylist.self)
        }
    }
    
}





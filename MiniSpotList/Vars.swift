//
//  Vars.swift
//  MiniSpotList
//
//  Created by Alec Keller on 10/9/17.
//  Copyright © 2017 AKKeller. All rights reserved.
//

import Cocoa
import SpotifyKit

class Vars: NSObject {
    static var playlists = [SpotifyLibraryItem]()
    static var selectedPlaylistUri = String()
    static var selectedPlaylistUserId = String()
    static var selectdPlaylistId = String()
    static var trackNames = [String]()
    static var tracks = [SpotifyTrack]()
    static var spotifyManager = SpotifyManager(with:
        SpotifyManager.SpotifyDeveloperApplication(
            clientId: "",
            clientSecret: "",
            redirectUri: "minispotlist://callback")
    )
    static var appDelegate = AppDelegate()
    static var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    static var popover = NSPopover()
}

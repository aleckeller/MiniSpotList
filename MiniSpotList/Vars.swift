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
    static var trackNames = [String]()
    static var tracks = [SpotifyTrack]()
    static var clientId = ""
    static var clientSecret = ""
    static var spotifyManager = SpotifyManager(with:
        SpotifyManager.SpotifyDeveloperApplication(
            clientId: "",
            clientSecret: "",
            redirectUri: "minispotlist://callback")
    )
}

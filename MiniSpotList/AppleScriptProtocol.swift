//
//  AppleScriptProtocol.swift
//  MiniSpotList
//
//  Created by Alec Keller on 10/8/17.
//  Copyright © 2017 AKKeller. All rights reserved.
//

import Foundation

@objc(NSObject) protocol AppleScriptProtocol {
    func playTrack(_: NSAppleEventDescriptor, userId: NSAppleEventDescriptor, playlistId: NSAppleEventDescriptor)
    func getCurrentPlaying() -> NSString
}

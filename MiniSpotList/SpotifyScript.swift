//
//  File.swift
//  MiniSpotList
//
//  Created by Alec Keller on 10/8/17.
//  Copyright © 2017 AKKeller. All rights reserved.
//

import Foundation
import AppleScriptObjC

class SpotifyScript {
    static func getTrack() -> AnyObject {
        Bundle.main.loadAppleScriptObjectiveCScripts()
        let ScriptObj = NSClassFromString("SpotifyScriptObj")
        let obj = ScriptObj!.alloc()
        return obj as AnyObject
    }
}

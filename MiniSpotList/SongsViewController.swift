//
//  SongsViewController.swift
//  MiniSpotList
//
//  Created by Alec Keller on 10/10/17.
//  Copyright © 2017 AKKeller. All rights reserved.
//

import Cocoa
import SpotifyKit

class SongsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var currentlyPlaying: NSTextField!
    @IBOutlet var tableView: NSTableView!
    var tracks = [SpotifyTrack]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
        currentlyPlaying.stringValue = Vars.appDelegate.getCurrentlyPlaying()
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tracks.count
    }
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if ((tableColumn?.identifier)!.rawValue == "songId"){
            var tempRow = row
            tempRow = tempRow + 1
            return tempRow.description
        }
        else if ((tableColumn?.identifier)!.rawValue == "songName"){
            return tracks[row].name
        }
        else if ((tableColumn?.identifier)!.rawValue == "songArtist"){
            return tracks[row].artist.name
        }
        return nil
    }
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        if (tableView.selectedRow >= 0){
            Vars.appDelegate.playSong(id: tracks[tableView.selectedRow].id)
            currentlyPlaying.stringValue = tracks[tableView.selectedRow].name
        }
    }
    
}

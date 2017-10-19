//
//  MiniSpotListViewController.swift
//  MiniSpotList
//
//  Created by Alec Keller on 10/6/17.
//  Copyright © 2017 AKKeller. All rights reserved.
//

import Cocoa
import SpotifyKit

class MiniSpotListViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return Vars.trackNames.count
    }
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if ((tableColumn?.identifier)!.rawValue == "id"){
            var tempRow = row
            tempRow = tempRow + 1
            return tempRow.description
        }
        else if ((tableColumn?.identifier)!.rawValue == "playlistName"){
            return Vars.trackNames[row]
        }
        return nil
    }
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
       self.selectedPlaylist(index: tableView.selectedRow)
    }
    func selectedPlaylist(index: Int){
        if (index >= 0){
            //erase previous contents
            Vars.selectedPlaylistUserId = ""
            Vars.selectdPlaylistId = ""
            let id = Vars.playlists[index].id
            Vars.selectedPlaylistUri = Vars.playlists[index].uri
            //get user id from the playlist uri
            var fromIndex = Vars.selectedPlaylistUri.index(Vars.selectedPlaylistUri.startIndex, offsetBy: 13)
            var secondHalf = Vars.selectedPlaylistUri.substring(from: fromIndex)
            for x in secondHalf{
                if (x != ":"){
                    Vars.selectedPlaylistUserId.append(x)
                }
                else{
                    break
                }
            }
            //get the playlist id from the uri
            fromIndex = Vars.selectedPlaylistUri.index(Vars.selectedPlaylistUri.startIndex, offsetBy: 33)
            secondHalf = Vars.selectedPlaylistUri.substring(from: fromIndex)
            for x in secondHalf{
                if (x != ":"){
                    Vars.selectdPlaylistId.append(x)
                }
                else{
                    break
                }
            }
            self.get(SpotifyPlaylist.self, id: id, playlistUserId: Vars.selectedPlaylistUserId)
        }
        
    }
    func get<T>(_ type: T.Type, id: String, playlistUserId: String? = nil) where T: SpotifySearchItem {
        Vars.spotifyManager.get(type, id: id,playlistUserId: playlistUserId) { result in
            if let collection = result as? SpotifyTrackCollection {
                Vars.tracks = collection.collectionTracks!
                self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "showSongsSegue"), sender: self)
            }
        }
    }
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        let secondViewController = segue.destinationController as! SongsViewController
        
        // set a variable in the second view controller with the data to pass
        secondViewController.tracks = Vars.tracks
    }
    
    
    
}
extension MiniSpotListViewController {
    static func freshController() -> MiniSpotListViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle:nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "MiniSpotListViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MiniSpotListViewController else {
            fatalError("Can't find MiniSpotListViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

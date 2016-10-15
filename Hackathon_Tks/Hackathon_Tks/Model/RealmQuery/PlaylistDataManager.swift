//
//  PlaylistDataManager.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
import RealmSwift

class PlaylistDataManager: NSObject {
    static var shareInstance = PlaylistDataManager()
    var realm = try! Realm()
    
    func insertPlaylistRealm(playList:Playlist){
        let newPlaylistDb = findFistPlaylistDbByID(playList.uuid)
        if newPlaylistDb.uuid != "" {
            try! realm.write {
                newPlaylistDb.createDate = NSDate()
            }
        }else {
            let newPlaylistDb = PlaylistDB()
            newPlaylistDb.uuid = playList.uuid
            newPlaylistDb.title = playList.title
            newPlaylistDb.createDate = NSDate()
            try! realm.write{
                realm.add(newPlaylistDb)
            }
        }
    }
    
    func getAllPlaylistRealm() -> [Playlist]{
        var playlists = [Playlist]()
        for playlistsDb in realm.objects(PlaylistDB).sorted("createDate",ascending: false){
            let ga = Playlist(playlistDB:playlistsDb)
            playlists.append(ga)
        }
        
        return playlists
    }
    
    func findFistPlaylistDbByID(uuid:String) -> PlaylistDB{
        let playlists = realm.objects(PlaylistDB).filter("uuid = %@",uuid)
        var playlist = PlaylistDB()
        if playlists.count == 1{
            playlist = playlists[0]
            return playlist
        }else {
            return playlist
        }
    }
    
    func deletePlaylistRealm(playlistDB:PlaylistDB){
        try! realm.write {
            realm.delete(playlistDB)
        }
    }
    
    func deleteAllPlaylistDB(){
        for playlistDB in realm.objects(PlaylistDB){
            try! realm.write {
                realm.delete(playlistDB)
            }
        }
    }
}

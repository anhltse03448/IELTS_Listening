//
//  PlaylistDataManager.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import Foundation
import RealmSwift

class SongPlaylistDataManager: NSObject {
    static var shareInstance = SongPlaylistDataManager()
    var realm = try! Realm()
    
    func insertSongPlaylistRealm(songPlayListDb:SongPlaylist){
        let newSongPlaylistDb = findFistSongPlaylistDbByID(songPlayListDb.uuidSong)
        if newSongPlaylistDb.uuidSong != "" {
            try! realm.write {
                newSongPlaylistDb.createDate = NSDate()
            }
        }else {
            let newSongPlaylistDb = SongPlaylistDB()
            newSongPlaylistDb.uuidPlaylist = songPlayListDb.uuidPlaylist
            newSongPlaylistDb.uuidSong = songPlayListDb.uuidSong
            newSongPlaylistDb.createDate = NSDate()
            try! realm.write{
                realm.add(newSongPlaylistDb)
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
    //truyen id -> sl bai
    func getCountPlaylistRealmById(uuid:String) -> Int{
        let playlistsDb = realm.objects(SongPlaylistDB).filter("uuidPlaylist = %@", uuid)
        return playlistsDb.count
    }
    //truyen id -> song first
    func findFistSongPlaylistDbByID(uuid:String) -> SongPlaylistDB{
        //let pre = NSPredicate.init(format: "uuidSong = %@", uuid)
        let songPlaylists = realm.objects(SongPlaylistDB).filter("uuidPlaylist = %@",uuid)
        var songPlaylist = SongPlaylistDB()
        if songPlaylists.count != 0{
            songPlaylist = songPlaylists[0]
            return songPlaylist
        }else {
            return songPlaylist
        }
    }
    
    func deleteSongPlaylistRealm(songPlaylistDB:SongPlaylistDB){
        try! realm.write {
            realm.delete(songPlaylistDB)
        }
    }
    
    func deleteAllSongPlaylistDB(){
        for songplaylistDB in realm.objects(SongPlaylistDB){
            try! realm.write {
                realm.delete(songplaylistDB)
            }
        }
    }
}

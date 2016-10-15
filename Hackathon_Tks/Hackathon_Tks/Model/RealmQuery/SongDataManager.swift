////
////  SongData.swift
////  Hackathon_Tks
////
////  Created by IchIT on 10/15/16.
////  Copyright © 2016 Anh Tuan. All rights reserved.
////
//
import Foundation
import UIKit
import RealmSwift

class SongDataManager: NSObject {
    static var shareInstance = SongDataManager()
    var realm = try! Realm()
    
    func insertSongRealm(song:Song){
        let newSongDb = findFistSongDbByID(song.uuid)
        if newSongDb.uuid != "" {
            try! realm.write {
                newSongDb.createDate = NSDate()
            }
        }else {
            
            let newSongDb = SongDB()
            newSongDb.uuid = song.uuid
            newSongDb.genreID = song.genreID
            newSongDb.title = song.title
            newSongDb.img = song.img
            newSongDb.length = song.length
            newSongDb.number_word  = song.number_word
            newSongDb.result  = song.result
            newSongDb.fileSource  = song.fileSource
            newSongDb.linkYoutube  = song.linkYoutube
            newSongDb.createDate = NSDate()
            try! realm.write{
                print(realm.configuration.fileURL)
                realm.add(newSongDb)
            }
        }
    }
    
    func getAllSongRealm() -> [Song]{
        var gallarys = [Song]()
        for gallaryDb in realm.objects(SongDB).sorted("createDate",ascending: false){
            let ga = Song(songDb:gallaryDb)
            gallarys.append(ga)
        }
        
        return gallarys
    }
    
    func findFistSongDbByID(uuid:String) -> SongDB{
        let songs = realm.objects(SongDB).filter("uuid = %@",uuid)
        var song = SongDB()
        if songs.count != 0{
            song = songs[0]
            return song
        }else {
            return song
        }
    }
    
    func DeleteGallaryRealm(songDB:SongDB){
        try! realm.write {
            realm.delete(songDB)
        }
    }
    func DeleteAllSong(){
        for songDB in realm.objects(SongDB){
            try! realm.write {
                realm.delete(songDB)
            }
        }
    }
  
}

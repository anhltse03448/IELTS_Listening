//
//  InitData.swift
//  Hackathon_Tks
//
//  Created by Anh Tuan on 10/13/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift

class InitData: NSObject {
    // khi nào cần mới thêm data. Vì mỗi lần thêm data ID sẽ khác nhau.
    class func initType() {
        SongDataManager.shareInstance.DeleteAllSong()
        GenreDataManager.shareInstance.DeleteAllGenreDB()
        let categoryTitle = ["Art and Culture" , "Conversation" , "Education" , "IELTS Listening" ,
                             "Entertainment", "Music", "Environment","News","Places",
                             "Science", "Story" , "Technology"]
        let linkCategory = ["Art_culture","Daily","Education",
                            "Ielts", "Leisure" ,
                            "Music","Nature","News",
                            "place","science","story","tech"]
        
        do {
            let realm = try! Realm()
            for item in categoryTitle {
                var genre = Genre()
                let number = categoryTitle.indexOf(item)
                genre.title = item
                genre.img = linkCategory[number!]
                
                GenreDataManager.shareInstance.insertGallryRealm(genre)
                
                for i in 0 ..< 4 {
                    if i == 0 {
                        let song = Song(genreID: genre.uuid, title: "Making Music", img: "making_music", length: "01:16", number_word: 142, result: 0, fileSource: "making_music", linkYoutube: "bfLCtQWPNl8")
                        SongDataManager.shareInstance.insertSongRealm(song)
                    } else if i == 1 {
                        let song = Song(genreID: genre.uuid, title: "Didier Drogba", img: "drogba", length: "02:41", number_word: 454, result: 0, fileSource: "drogba", linkYoutube: "9bVzXT0B-04")
                        SongDataManager.shareInstance.insertSongRealm(song)
                    } else if i == 2 {
                        let song = Song(genreID: genre.uuid, title: "Central Park Playground", img: "central", length: "01:51", number_word: 285, result: 0, fileSource: "central", linkYoutube: "G1PF7ECvtpQ")
                        SongDataManager.shareInstance.insertSongRealm(song)
                    }
                    
                }
            }
        } catch let _ as NSError {
            // handle error
        }
    }
   

}

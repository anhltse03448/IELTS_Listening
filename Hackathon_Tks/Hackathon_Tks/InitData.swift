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

        SongData.shareInstance.DeleteAllSong()
        GenreData.shareInstance.DeleteAllGenreDB()
        let categoryTitle = ["Art and Culture" , "Daily conversation" , "Education" , "IELTS Listening" ,"Joke" ,
                             "Leisure & Entertainment", "Music", "Nature & Environment","News","Places",
                             "Science", "Story" , "Technology"]
        let linkCategory = ["Art_culture","Daily","Education",
                            "Ielts", "Joke","Leisure" ,
                            "Music","Nature","News",
                            "place","science","story","tech"]
        
        do {
            for item in categoryTitle {
                var genre = Genre()
                let number = categoryTitle.indexOf(item)
                genre.title = item
                genre.img = linkCategory[number!]
                
                GenreData.shareInstance.insertGallryRealm(genre)
               
                for i in 0 ..< 4 {
                    var song = Song()
                    song.genreID = genre.uuid
                    song.title = "Ballet Class"
                    //song.img = "http://elcontent.ieltsonlinetests.com/fileman/Uploads/Images/ielts/Ballet%Class.jpg"
                    song.img = "http://elcontent.ieltsonlinetests.com/fileman/Uploads/Images/ielts/ielts%2010/Writing%20the%20dissertation.jpg"
                    song.length = "01:11"
                    song.number_word  = 145
                    song.result  = 0
                    song.fileSource  = "data1"
                    song.linkYoutube  = "Rqk-JqaAg1w"
                    SongData.shareInstance.insertSongRealm(song)
                }
                
            }
        } catch let _ as NSError {
            // handle error
        }
    }
   

}

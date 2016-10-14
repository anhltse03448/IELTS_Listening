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
    
    class func initType() {
        InitData.clearData()
        let categoryTitle = ["Art and Culture" , "Daily conversation" , "Education" , "IELTS Listening" ,"Joke" ,
                             "Leisure & Entertainment", "Music", "Nature & Environment","News","Places",
                             "Science", "Story" , "Technology"]
        let linkCategory = ["Art_culture","Daily","Education",
                            "Ielts", "Joke","Leisure" ,
                            "Music","Nature","News",
                            "place","science","story","tech"]
        do {
            let realm = try Realm()
            for item in categoryTitle {
                let obj = Genre()
                let number = categoryTitle.indexOf(item)
                obj.uuid = NSUUID().UUIDString
                obj.title = item
                obj.img = linkCategory[number!]
                try! realm.write {
                    realm.add(obj)
                }
                for i in 0 ..< 4 {
                    let song = Song()
                    song.setValue(NSUUID().UUIDString , genreID: obj.uuid, title : "Ballet Class", img: "http://elcontent.ieltsonlinetests.com/fileman/Uploads/Images/ielts/Ballet%Class.jpg", length: "01:11", number_word: 145, fileSource: "data1", linkYoutube: "Rqk-JqaAg1w", result: 0)
                    try! realm.write {
                        realm.add(song)
                    }
                }
                
            }
        } catch let _ as NSError {
            // handle error
        }
    }
    class func clearData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

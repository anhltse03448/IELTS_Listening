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
        let categoryTitle = ["Conversation" , "Education" , "Art and Culture" , "IELTS Listening" ,
                             "Entertainment", "Music", "Environment","News","Places",
                             "Science", "Story" , "Technology"]
        let linkCategory = ["Daily","Education","Art_culture",
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
                if number == 0 { //conversasion
                    for i in 0 ..< 5 {
                        if i == 0 {
                            let song = Song(genreID: genre.uuid, title: "The future of Management", img: "futureOfManagement", length: "04:51", number_word: 664, result: 0, fileSource: "futureOfManagement", linkYoutube: "nKOU2AgYwDI")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 1 {
                            let song = Song(genreID: genre.uuid, title: "The spirit bear", img: "spirit_bear", length: "04:21", number_word: 454, result: 0, fileSource: "spiritbrear", linkYoutube: "3s_uRalmsyc")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 2 {
                            let song = Song(genreID: genre.uuid, title: "World Tours", img: "World_tour", length: "02:36", number_word: 440, result: 0, fileSource: "WorldTours", linkYoutube: "x7bZAe1Asus")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 3 {
                            let song = Song(genreID: genre.uuid, title: "A balanced diet", img: "balenced_diet", length: "02:41", number_word: 399, result: 0, fileSource: "balancedDiet", linkYoutube: "A-wH1OM08oE")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 4 {
                            let song = Song(genreID: genre.uuid, title: "Can you help me?", img: "help_me", length: "00:55", number_word: 119, result: 0, fileSource: "canyouhelpme", linkYoutube: "O01Pbs6ttbM")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        }
                    }
                } else if number == 1{ //education
                    for i in 0 ..< 5 {
                        if i == 0 {
                            let song = Song(genreID: genre.uuid, title: "How to Make a Country Rich", img: "country_rich", length: "09:06", number_word: 1445, result: 0, fileSource: "country_rich", linkYoutube: "Y9zThcMJzQU")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 1 {
                            let song = Song(genreID: genre.uuid, title: "The lesson of unity", img: "lesson_unity", length: "1:10", number_word: 139, result: 0, fileSource: "lesson_unity", linkYoutube: "LxIbJL7y9bs")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 2 {
                            let song = Song(genreID: genre.uuid, title: "You Can Learn Anything", img: "learn_anything", length: "1:31", number_word: 167, result: 0, fileSource: "learn_anything", linkYoutube: "Fp7BcbYpLXw")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 3 {
                            let song = Song(genreID: genre.uuid, title: "Success In Debating and Business", img: "debate", length: "5:29", number_word: 600, result: 0, fileSource: "balancedDiet", linkYoutube: "4XUREHw7MmU")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 4 {
                            let song = Song(genreID: genre.uuid, title: "An Introduction to British Agriculture", img: "british", length: "3:36", number_word: 645, result: 0, fileSource: "a", linkYoutube: "1HBxY9LpxHM")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        }
                    }
                    
                } else if number == 3 {
                    
                } else if number == 2 {
                    
                }
                else if number == 4 { //entertaimain
                    /*for i in 0 ..< 5 {
                        if i == 0 {
                            let song = Song(genreID: genre.uuid, title: "Work clothes", img: "Work_clothe", length: "1:48", number_word: 236, result: 0, fileSource: "Work_clothe", linkYoutube: "ReND1tWd61E")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 1 {
                            let song = Song(genreID: genre.uuid, title: "The Real Story Behind Donald Trump's Wealth", img: "donald_trump", length: "5:51", number_word: 907, result: 0, fileSource: "donald_trump", linkYoutube: "Ej1hlQgwXcA")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 2 {
                            let song = Song(genreID: genre.uuid, title: "India", img: "India", length: "1:45", number_word: 263, result: 0, fileSource: "India", linkYoutube: "vYOF0McW_xc")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 3 {
                            let song = Song(genreID: genre.uuid, title: "Halloween", img: "Halloween", length: "6:55", number_word: 593, result: 0, fileSource: "Halloween", linkYoutube: "aQpMGfJTFQg")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 4 {
                            let song = Song(genreID: genre.uuid, title: "The Second Presidential Debate 2016", img: "Presidential", length: "1:56", number_word: 296, result: 0, fileSource: "Presidential", linkYoutube: "kykS0uAnpsQ")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        }
                    }*/
                } else if number == 6 { //enviroment
                    /*
                    for i in 0 ..< 5 {
                        if i == 0 {
                            let song = Song(genreID: genre.uuid, title: "How Can a Plants Kill?", img: "futureOfManagement", length: "1:10", number_word: 142, result: 0, fileSource: "futureOfManagement", linkYoutube: "9O4ephIftew")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 1 {
                            let song = Song(genreID: genre.uuid, title: "The date palm", img: "spirit_bear", length: "1:44", number_word: 186, result: 0, fileSource: "spiritbrear", linkYoutube: "5dwxI2stlds")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 2 {
                            let song = Song(genreID: genre.uuid, title: "Rice", img: "World_tour", length: "1:58", number_word: 244, result: 0, fileSource: "WorldTours", linkYoutube: "Zj8ZCBXnrYE")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 3 {
                            let song = Song(genreID: genre.uuid, title: "The Hippopotamus", img: "balenced_diet", length: "1:20", number_word: 187, result: 0, fileSource: "balancedDiet", linkYoutube: "IgPvQuiQDNM")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 4 {
                            let song = Song(genreID: genre.uuid, title: "Coffee plant", img: "help_me", length: "1:41", number_word: 218, result: 0, fileSource: "canyouhelpme", linkYoutube: "APvPQBjgJQU")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        }
                    }
                    */
                } else if number == 7 { //news
                   
                } else if number == 8 { //places
                    
                } else if number == 9 { //science
                    /*for i in 0 ..< 5 {
                        if i == 0 {
                            let song = Song(genreID: genre.uuid, title: "Crying for Health", img: "futureOfManagement", length: "9:40", number_word: 839, result: 0, fileSource: "futureOfManagement", linkYoutube: "c14QxMS7fag")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 1 {
                            let song = Song(genreID: genre.uuid, title: "Why Do We Yawn?", img: "spirit_bear", length: "1:35", number_word: 162, result: 0, fileSource: "spiritbrear", linkYoutube: "EL44XGMlMH8")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 2 {
                            let song = Song(genreID: genre.uuid, title: "The Falkirk Wheel - How it works", img: "World_tour", length: "6:17", number_word: 585, result: 0, fileSource: "WorldTours", linkYoutube: "k27gOmrDgpo")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 3 {
                            let song = Song(genreID: genre.uuid, title: "Oranges", img: "balenced_diet", length: "1:39", number_word: 197, result: 0, fileSource: "balancedDiet", linkYoutube: "20iwDPZv7nQ")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 4 {
                            let song = Song(genreID: genre.uuid, title: "Why Do People Laugh?", img: "help_me", length: "1:36", number_word: 198, result: 0, fileSource: "canyouhelpme", linkYoutube: "7oylslYJK_U")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        }
                    } */
                } else if number == 10 {
                    /*for i in 0 ..< 5 {
                        if i == 0 {
                            let song = Song(genreID: genre.uuid, title: "At the cinema", img: "futureOfManagement", length: "1:16", number_word: 143, result: 0, fileSource: "futureOfManagement", linkYoutube: "pUjZgXCR40s")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 1 {
                            let song = Song(genreID: genre.uuid, title: "What does he do everyday?", img: "spirit_bear", length: "0:51", number_word: 117, result: 0, fileSource: "spiritbrear", linkYoutube: "uLkdGnGXJx8")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 2 {
                            let song = Song(genreID: genre.uuid, title: "THE ELECTION RESULT", img: "World_tour", length: "0:51", number_word: 155, result: 0, fileSource: "WorldTours", linkYoutube: "BM6QcnFsjvw")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 3 {
                            let song = Song(genreID: genre.uuid, title: "FOUR LIVES", img: "balenced_diet", length: "1:11", number_word: 176, result: 0, fileSource: "balancedDiet", linkYoutube: "BEVFgK59xOU")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 4 {
                            let song = Song(genreID: genre.uuid, title: "A HARD LIFE", img: "help_me", length: "1:26", number_word: 240, result: 0, fileSource: "canyouhelpme", linkYoutube: "AqTL-YM0QIU")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        }
                    }*/
                } else if number == 11 {
                    /*for i in 0 ..< 5 {
                        if i == 0 {
                            let song = Song(genreID: genre.uuid, title: "Google Announces New Services and Products", img: "futureOfManagement", length: "7:32", number_word: 801, result: 0, fileSource: "futureOfManagement", linkYoutube: "bFspgijeioI")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 1 {
                            let song = Song(genreID: genre.uuid, title: "How children learn through the media", img: "spirit_bear", length: "3:01", number_word: 594, result: 0, fileSource: "spiritbrear", linkYoutube: "fwteblOOv30")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 2 {
                            let song = Song(genreID: genre.uuid, title: "A New Camera", img: "World_tour", length: "1:01", number_word: 154, result: 0, fileSource: "WorldTours", linkYoutube: "TR6KR3ViOqE")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 3 {
                            let song = Song(genreID: genre.uuid, title: "WWDC 2016: watchOS", img: "balenced_diet", length: "6:11", number_word: 617, result: 0, fileSource: "balancedDiet", linkYoutube: "BklNJbeSnjg")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        } else if i == 4 {
                            let song = Song(genreID: genre.uuid, title: "Introducing Apple Pencil", img: "help_me", length: "2:35", number_word: 236, result: 0, fileSource: "canyouhelpme", linkYoutube: "AOhTrj0YMrs")
                            SongDataManager.shareInstance.insertSongRealm(song)
                        }
                    }*/
                }
            }
        } catch let _ as NSError {
            // handle error
        }
    }
    
    
}

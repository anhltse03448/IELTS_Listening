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

class FavoriteData: NSObject {
    static var shareInstance = FavoriteData()
    var realm = try! Realm()
    
    func insertFavoriteRealm(favorite:Favorite){
        let newFavorite = findFistFavoriteDbByID(favorite.songID)
        if newFavorite.songID != "" {
            try! realm.write {
                newFavorite.createDate = NSDate()
            }
        }else {
            
            let newFavorite = FavoriteDB()
            newFavorite.songID = favorite.songID
            newFavorite.createDate = NSDate()
            try! realm.write{
                realm.add(newFavorite)
            }
        }
    }
    
    func getAllFavoriteRealm() -> [Favorite]{
        var favorites = [Favorite]()
        for favoriteDb in realm.objects(FavoriteDB).sorted("createDate",ascending: false){
            let ga = Favorite(favoriteDB:favoriteDb)
            favorites.append(ga)
        }
        
        return favorites
    }
    
    func findFistFavoriteDbByID(songID:String) -> FavoriteDB{
        let favorites = realm.objects(FavoriteDB).filter("songID = %@",songID)
        var favorite = FavoriteDB()
        if favorites.count == 1{
            favorite = favorites[0]
            return favorite
        }else {
            return favorite
        }
    }
    
    func DeleteFavoriteRealm(favoriteDB:FavoriteDB){
        try! realm.write {
            realm.delete(favoriteDB)
        }
    }
    
    func DeleteAllFavorite(){
        for favoriteDb in realm.objects(FavoriteDB){
            try! realm.write {
                realm.delete(favoriteDb)
            }
        }
    }
}

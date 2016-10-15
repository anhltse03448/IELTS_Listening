//
//  GenreData.swift
//  Hackathon_Tks
//
//  Created by IchIT on 10/15/16.
//  Copyright © 2016 Anh Tuan. All rights reserved.
//

import UIKit
import RealmSwift

class GenreDataManager: NSObject {
    static var shareInstance = GenreDataManager()
    var realm = try! Realm()
    
    func insertGallryRealm(genre:Genre){
        let newGenreDb = findFistgenreDbByID(genre.uuid)
        if newGenreDb.uuid != "" {
            try! realm.write {
                newGenreDb.createDate = NSDate()
            }
        }else {
            let newGenreDb = GenreDB()
            newGenreDb.uuid = genre.uuid
            newGenreDb.title = genre.title
            newGenreDb.img = genre.img
            
            newGenreDb.createDate = NSDate()
            try! realm.write{
                realm.add(newGenreDb)
            }
        }
    }
    
    func getAllGenreRealm() -> [Genre]{
        var genres = [Genre]()
        for genreDb in realm.objects(GenreDB).sorted("createDate",ascending: false){
            let ga = Genre(genreDb:genreDb)
            genres.append(ga)
        }
        
        return genres
    }
    
    func findFistgenreDbByID(uuid:String) -> GenreDB{
        let genres = realm.objects(GenreDB).filter("uuid = %@",uuid)
        var genre = GenreDB()
        if genres.count == 1{
            genre = genres[0]
            return genre
        }else {
            return genre
        }
    }
    
    func DeleteGallaryRealm(genreDB:GenreDB){
        try! realm.write {
            realm.delete(genreDB)
        }
    }
    
    func DeleteAllGenreDB(){
        for genreDB in realm.objects(GenreDB){
            try! realm.write {
                realm.delete(genreDB)
            }
        }
    }
}

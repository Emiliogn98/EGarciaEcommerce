//
//  DBManager.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 28/04/23.
//

import Foundation
import SQLite3

public class DBManager {
    
    let dbPath: String = "EGarciaDBEcommerce.sqlite"
    var db:OpaquePointer?
    
    init()
    {
        db = Get()
    
    }
    
    
    
    func Get() -> OpaquePointer?
    {
        let filePath = try! FileManager.default.url(for:
                .documentDirectory, in:
                .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            print("fallo la conexion")
            return nil
        }
        else
        {
            print("conexion existosa el pat: \(filePath)")
            return db
        }
    }
}
//    func createTable() {
//            let createTableString = "CREATE TABLE IF NOT EXISTS Usuario(Id INTEGER PRIMARY KEY,Nombre TEXT,ApellidoPaterno TEXT, ApellidoMaterno TEXT,FechaNacimiento TEXT,UserName TEXT,Password TEXT);"
//            var createTableStatement: OpaquePointer? = nil
//            if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
//            {
//                if sqlite3_step(createTableStatement) == SQLITE_DONE
//                {
//                    print("person table created.")
//                } else {
//                    print("person table could not be created.")
//                }
//            } else {
//                print("CREATE TABLE statement could not be prepared.")
//            }
//            sqlite3_finalize(createTableStatement)
//        }
       




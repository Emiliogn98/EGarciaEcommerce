//
//  AreaViewModel.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 18/05/23.
//

import Foundation
import SQLite3
class AreaViewModel{
    static func GetAll()-> Result
     {
         var context = DBManager()
         var result = Result()
         var query = "SELECT IdArea,Nombre from Area"
     
         var statement: OpaquePointer? = nil
         do {
             if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                 result.Objects = []
                 while try sqlite3_step(statement) == SQLITE_ROW {
                     var area = Area()
                     area.IdArea = Int(sqlite3_column_int(statement, 0))
                     area.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                     
                     
                     result.Objects?.append(area)
                 }
                 result.Correct = true
             } else {
                 result.Correct = false
                 print("ocurrio un error")
             }
             sqlite3_finalize(statement)
             
             sqlite3_close(context.db)
         }
         catch let ex {
             result.Correct = false
             result.ErrorMessage = ex.localizedDescription
             result.Ex = ex
         }
         return result
     }
    
}

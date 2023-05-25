//
//  DepartamentoViewModel.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 17/05/23.
//

import Foundation
import SQLite3

class DepartamentoViewModel {
    static func GetAll()-> Result
     {
         var context = DBManager()
         var result = Result()
         var query = "SELECT IdDepartamento,Nombre from Departamento"
     
         var statement: OpaquePointer? = nil
         do {
             if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                 result.Objects = []
                 while try sqlite3_step(statement) == SQLITE_ROW {
                     var departamento = Departamento()
                     departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                     departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                     
                     
                     result.Objects?.append(departamento)
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
    static func GetByArea(IdArea : Int)-> Result
     {
         var context = DBManager()
         var result = Result()
         var query = "SELECT IdDepartamento,Nombre from Departamento Where IdArea=\(IdArea);"
     
         var statement: OpaquePointer? = nil
         do {
             if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                 result.Objects = []
                 while try sqlite3_step(statement) == SQLITE_ROW {
                     var departamento = Departamento()
                     departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                     departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                     
                     
                     result.Objects?.append(departamento)
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
    static func GetById(IdArea: Int) -> Result
    {
        var context = DBManager()
        var result = Result()
        var query = "SELECT IdDepartamento,Nombre from Departamento WHERE IdArea=\(IdArea);"
 
        var statement: OpaquePointer? = nil
        do {
            
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                let departamento = Departamento()
                   
                if try sqlite3_step(statement) == SQLITE_ROW {
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                    
                    result.Objects?.append(departamento) 
                    result.Correct=true
                } else {
                    print("ocurrio un error al obtener departamento")
                    result.Correct=false
                    
                }
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

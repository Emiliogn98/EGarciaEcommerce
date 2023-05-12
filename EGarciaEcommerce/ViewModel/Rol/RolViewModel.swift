//
//  RolViewModel.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 09/05/23.
//

import Foundation
import SQLite3

class RolViewModel {
    
    static func Add(rol : Rol) -> Result{
        var context = DBManager()
        var result = Result()
        var query = "INSERT INTO Rol(Nombre) VALUES (?)"
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db,query, -1,&statement, nil) == SQLITE_OK{
                
                
                sqlite3_bind_text(statement,1,(rol.Nombre! as NSString).utf8String,-1,nil)
                
                    
                if try sqlite3_step(statement) == SQLITE_DONE {
                    print("rol insertado.")
                    result.Correct = true
                } else {
                    print("ocurrio un error al insertar")
                    result.Correct = false
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(context.db)
        }//do
        catch let ex {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    
    static func Update(rol : Rol) -> Result{
        var context = DBManager()
        var result = Result()
        var query = "UPDATE Rol SET Nombre= ? WHERE IdRol = \(rol.IdRol!)"
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement,nil) == SQLITE_OK {
                
                sqlite3_bind_text(statement,1,(rol.Nombre! as NSString).utf8String, -1, nil)
                if try sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("rol actualizado")
                }else {
                    result.Correct = false
                }
                
            }
        }
        catch let ex {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    static func Delete(IdRol : Int) -> Result {
        var context = DBManager()
        var result = Result()
        var query = "DELETE FROM Rol WHERE IdRol=\(IdRol);"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db,query,-1, &statement, nil) == SQLITE_OK{
                
                if try sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("rol eliminado")
                }else {
                    result.Correct = false
                }
                
            }
        }
        catch let ex {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    static func GetAll()-> Result{
        var context = DBManager()
        var result = Result()
        var query = "Select IdRol,Nombre from Rol"
        var statement: OpaquePointer? = nil
        
        do{
            
            if try sqlite3_prepare_v2(context.db,query,-1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var rol = Rol()
                    rol.IdRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    result.Objects?.append(rol)
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                print("ocurrio un error")
            }
            sqlite3_finalize(statement)
            sqlite3_close(context.db)
        }//do
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    static func GetById (IdRol : Int)-> Result{
        var context = DBManager()
        var result = Result()
        var rol = Rol()
        var query = "Select IdRol, Nombre from Rol WHERE IdRol =\(IdRol)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query,-1,&statement,nil) == SQLITE_OK{
                if try sqlite3_step(statement) == SQLITE_ROW{
                    rol.IdRol = Int(sqlite3_column_int(statement, 0))
                    rol.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    result.Object = rol
                    result.Correct = true
                }
                else{
                    result.Correct = false
                    print("Ocurrio un error")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(context.db)
        }// do
        catch let ex {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
            
        }
        return result
    }
    
}//class

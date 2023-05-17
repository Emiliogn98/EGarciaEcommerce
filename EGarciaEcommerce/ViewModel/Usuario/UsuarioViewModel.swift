//
//  UsuarioViewModel.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 04/05/23.
//

import Foundation
import SQLite3

class UsuarioViewModel {
    
    
    // metodos
    static func Add(usuario: Usuario) -> Result
    {
        var context = DBManager()
        var result = Result()
        var query = "INSERT INTO Usuario (Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, UserName, Password, IdRol) VALUES (?,?,?,?,?,?,?);"
        var insertStatement: OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &insertStatement, nil) == SQLITE_OK {
                
                sqlite3_bind_text(insertStatement, 1, (usuario.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (usuario.ApellidoMaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (usuario.FechaNacimiento! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (usuario.UserName! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, (usuario.Password! as NSString).utf8String, -1, nil)
               //usuario.Rol = Rol()
                sqlite3_bind_int(insertStatement, 7, Int32(usuario.Rol!.IdRol! as Int))
                
                
                if try sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("usuario insertado.")
                    result.Correct = true
                } else {
                    print("ocurrio un error al insertar")
                    result.Correct = false
                }
            }
            sqlite3_finalize(insertStatement)
            sqlite3_close(context.db)
        }
        catch let ex {
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    
    static func Update(usuario: Usuario) -> Result
    {
        var context = DBManager()
        var result = Result()
        
        let query = "UPDATE Usuario SET Nombre =?, ApellidoPaterno =?, ApellidoMaterno =?,FechaNacimiento =?, UserName =?, Password =?, IdRol =? WHERE IdUsuario =\(usuario.IdUsuario!);"
        var insertStatement: OpaquePointer? = nil
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &insertStatement, nil) == SQLITE_OK {
                
                
                sqlite3_bind_text(insertStatement, 1, (usuario.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (usuario.ApellidoMaterno! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (usuario.FechaNacimiento! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (usuario.UserName! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, (usuario.Password! as NSString).utf8String, -1, nil)
               
                sqlite3_bind_int(insertStatement, 7, Int32(usuario.Rol!.IdRol! as Int))
               // sqlite3_bind_int(insertStatement, 7, Int32(usuario.IdUsuario! as Int))
                
                
                if try sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("usuario actualizado.")
                    result.Correct=true
                } else {
                    print("ocurrio un error al insertar")
                    result.Correct=false
                }
            }
            sqlite3_finalize(insertStatement)
            sqlite3_close(context.db)
            
        }
        catch let ex{
            result.Correct=false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    
    static func Delete(IdUsuario:Int) -> Result
    {
        var context = DBManager()
        let result = Result()
        let query = "DELETE FROM Usuario WHERE IdUsuario = \(IdUsuario)"
        var statement: OpaquePointer? = nil
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                //  sqlite3_bind_int(deleteStatement, 1, Int32(usuario.IdUsuario! as Int))
                if try sqlite3_step(statement) == SQLITE_DONE {
                    print("Usuario Eliminado")
                    result.Correct=true
                    
                } else {
                    result.ErrorMessage = "Ocurrio un error al eliminar"
                    result.Correct=false
                }
            } else{
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error al eliminar"
            }
            sqlite3_finalize(statement)
            
            sqlite3_close(context.db)
            
        }
        catch let ex {
            
            result.Correct=false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        return result
    }
    
   static func GetAll()-> Result
    {
        var context = DBManager()
        var result = Result()
        var query = "SELECT IdUsuario,Usuario.Nombre as NombreUsuarios,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,UserName,Password, Usuario.IdRol, Rol.Nombre as Roles FROM Usuario INNER JOIN Rol  on Rol.IdRol = Usuario.IdRol"
      //  var query = "SELECT IdUsuario,Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,UserName,Password FROM Usuario;"
        var statement: OpaquePointer? = nil
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var usuario = Usuario()
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement,2)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement,3)))
                    usuario.FechaNacimiento = String(describing: String(cString: sqlite3_column_text(statement,4)))
                    usuario.UserName = String(describing: String(cString: sqlite3_column_text(statement,5)))
                    usuario.Password = String(describing: String(cString: sqlite3_column_text(statement,6)))
                    usuario.Rol = Rol()
                    usuario.Rol?.IdRol = Int(sqlite3_column_int(statement, 7))
                    usuario.Rol?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,8)))
                    
                    
                    result.Objects?.append(usuario)
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
    static func GetById(IdUsuario: Int) -> Result
    {
        var context = DBManager()
        var result = Result()
        var query = "SELECT IdUsuario,Usuario.Nombre as NombreUsuarios,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,UserName,Password, Usuario.IdRol, Rol.Nombre as Roles FROM Usuario INNER JOIN Rol  on Rol.IdRol = Usuario.IdRol WHERE IdUsuario=\(IdUsuario);"
    //    var query = "SELECT IdUsuario,Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,UserName,Password FROM Usuario WHERE IdUsuario=\(IdUsuario);"
        var statement: OpaquePointer? = nil
        do {
            
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                  
                let usuario = Usuario()
                   
                if try sqlite3_step(statement) == SQLITE_ROW {
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement,2)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement,3)))
                    usuario.FechaNacimiento = String(describing: String(cString: sqlite3_column_text(statement,4)))
                    usuario.UserName = String(describing: String(cString: sqlite3_column_text(statement,5)))
                    usuario.Password = String(describing: String(cString: sqlite3_column_text(statement,6)))
                    usuario.Rol = Rol()
                    usuario.Rol?.IdRol = Int(sqlite3_column_int(statement, 7))
                    usuario.Rol?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,8)))
                    result.Object = usuario
                    result.Correct=true
                } else {
                    print("ocurrio un error al obtener usuario")
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
    //class
}

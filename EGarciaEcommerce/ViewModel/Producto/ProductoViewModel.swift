//
//  ProductoViewModel.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 16/05/23.
//

import Foundation
import SQLite3

class ProductoViewModel {
    
    
    //metodos
    static func Add(producto : Producto) -> Result{
        var context = DBManager()
        let result = Result()
        let query = "INSERT INTO Producto (Nombre,PrecioUnitario,Stock,Descripcion,Imagen,IdProveedor,IdDepartamento) VALUES(?,?,?,?,?,?,?)"
        var statement: OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, Double(producto.PrecioUnitario! as Double))
                sqlite3_bind_int(statement, 3, Int32(producto.Stock! as Int))
                sqlite3_bind_text(statement, 4, (producto.Descripcion! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 5, (producto.Imagen! as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 6, Int32(producto.Proveedor!.IdProveedor! as Int))
                sqlite3_bind_int(statement, 7, Int32(producto.Departamento!.IdDepartamento! as Int))
                
                
                if try sqlite3_step(statement) == SQLITE_DONE {
                    print("Producto insertado.")
                    result.Correct = true
                } else {
                    print("ocurrio un error al insertar")
                    result.Correct = false
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
    static func Update(producto : Producto) -> Result{
        var context = DBManager()
        let result = Result()
        let query =  "UPDATE Producto SET Nombre =?, PrecioUnitario =?, Stock =?,Descripcion =?, Imagen =?, IdProveedor =?, IdDepartamento =? WHERE IdProducto =\(producto.IdProducto!);"

        var statement: OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, Double(producto.PrecioUnitario! as Double))
                sqlite3_bind_int(statement, 3, Int32(producto.Stock! as Int))
                sqlite3_bind_text(statement, 4, (producto.Descripcion! as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 5, (producto.Imagen! as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 6, Int32(producto.Proveedor!.IdProveedor! as Int))
                sqlite3_bind_int(statement, 7, Int32(producto.Departamento!.IdDepartamento! as Int))
                
                
                if try sqlite3_step(statement) == SQLITE_DONE {
                    print("Producto actualizado.")
                    result.Correct = true
                } else {
                    print("ocurrio un error al actualizar")
                    result.Correct = false
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
    static func Delete(IdProducto:Int) -> Result
    {
        var context = DBManager()
        let result = Result()
        let query = "DELETE FROM Producto WHERE IdProducto = \(IdProducto)"
        var statement: OpaquePointer? = nil
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                //  sqlite3_bind_int(deleteStatement, 1, Int32(usuario.IdUsuario! as Int))
                if try sqlite3_step(statement) == SQLITE_DONE {
                    print("Producto Eliminado")
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
         var query = "SELECT IdProducto,Producto.Nombre as NombreProductos,PrecioUnitario,Stock,Descripcion,Imagen,Producto.IdProveedor,Proveedor.Nombre as Proveedor, Producto.IdDepartamento,Departamento.Nombre as Departamento FROM Producto INNER JOIN Proveedor  on Proveedor.IdProveedor = Producto.IdProveedor INNER JOIN Departamento on Departamento.IdDepartamento = Producto.IdDepartamento"
     
         var statement: OpaquePointer? = nil
         do {
             if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                 result.Objects = []
                 while try sqlite3_step(statement) == SQLITE_ROW {
                     var producto = Producto()
                     producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                     producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                     producto.PrecioUnitario = Double(sqlite3_column_double(statement,2))
                     producto.Stock = Int(sqlite3_column_int(statement,3))
                     producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement,4)))
                     producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement,5)))
                     producto.Proveedor = Proveedor()
                     producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 6))
                     producto.Proveedor?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,7)))
                     producto.Departamento = Departamento()
                     producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
                     producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,9)))
                     
                     
                     result.Objects?.append(producto)
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
    static func GetByDepartamento(IdDepartamento: Int)-> Result
     {
         var context = DBManager()
         var result = Result()
         var query = "SELECT IdProducto,Producto.Nombre as NombreProductos,PrecioUnitario,Stock,Descripcion,Imagen,Producto.IdProveedor,Proveedor.Nombre as Proveedor, Producto.IdDepartamento,Departamento.Nombre as Departamento FROM Producto INNER JOIN Proveedor  on Proveedor.IdProveedor = Producto.IdProveedor INNER JOIN Departamento on Departamento.IdDepartamento = Producto.IdDepartamento WHERE Producto.IdDepartamento=\(IdDepartamento)"
     
         var statement: OpaquePointer? = nil
         do {
             if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                 result.Objects = []
                 while try sqlite3_step(statement) == SQLITE_ROW {
                     var producto = Producto()
                     producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                     producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                     producto.PrecioUnitario = Double(sqlite3_column_double(statement,2))
                     producto.Stock = Int(sqlite3_column_int(statement,3))
                     producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement,4)))
                     producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement,5)))
                     producto.Proveedor = Proveedor()
                     producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 6))
                     producto.Proveedor?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,7)))
                     producto.Departamento = Departamento()
                     producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
                     producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,9)))
                     
                     
                     result.Objects?.append(producto)
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
    static func GetById(IdProducto: Int) -> Result
    {
        var context = DBManager()
        var result = Result()
        var query = "SELECT IdProducto,Producto.Nombre as NombreProductos,PrecioUnitario,Stock,Descripcion,Imagen,Producto.IdProveedor,Proveedor.Nombre as Proveedor, Producto.IdDepartamento,Departamento.Nombre as Departamento FROM Producto INNER JOIN Proveedor  on Proveedor.IdProveedor = Producto.IdProveedor INNER JOIN Departamento on Departamento.IdDepartamento = Producto.IdDepartamento WHERE IdProducto = \(IdProducto)"
  
        var statement: OpaquePointer? = nil
        do {
            
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                  
                let producto = Producto()
                   
                if try sqlite3_step(statement) == SQLITE_ROW {
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement,2))
                    producto.Stock = Int(sqlite3_column_int(statement,3))
                    producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement,4)))
                    producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement,5)))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 6))
                    producto.Proveedor?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,7)))
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,9)))
                    result.Object = producto
                    result.Correct=true
                } else {
                    print("ocurrio un error al obtener el producto")
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
    static func GetByName(nombreProducto: String) -> Result
    {
        var context = DBManager()
        var result = Result()
        var query = "SELECT IdProducto,Producto.Nombre as NombreProductos,PrecioUnitario,Stock,Descripcion,Imagen,Producto.IdProveedor,Proveedor.Nombre as Proveedor, Producto.IdDepartamento,Departamento.Nombre as Departamento FROM Producto INNER JOIN Proveedor  on Proveedor.IdProveedor = Producto.IdProveedor INNER JOIN Departamento on Departamento.IdDepartamento = Producto.IdDepartamento WHERE Producto.Nombre LIKE '%\(nombreProducto)%'"
  
        var statement: OpaquePointer? = nil
        do {
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement,1)))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement,2))
                    producto.Stock = Int(sqlite3_column_int(statement,3))
                    producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement,4)))
                    producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement,5)))
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 6))
                    producto.Proveedor?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,7)))
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement,9)))
                    
                    
                    result.Objects?.append(producto)
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
    
    
    //class
}

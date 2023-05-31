//
//  CarritoViewModel.swift
//  JBecerraEcommerce
//
//  Created by MacbookMBA7 on 26/05/23.
//

import Foundation
import UIKit
import CoreData

class CarritoViewModel{
    //var productoVenta : [Venta] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func Add(_ IdProducto : Int) -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)!
        
        let producto = NSManagedObject(entity: entity, insertInto: context)
        
        producto.setValue(IdProducto, forKey: "idProducto")
        producto.setValue(1, forKey: "cantidad")
        
        do{
            try context.save()
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        return result
    }
    func Delete(_ IdProducto : Int) -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
 
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        response.predicate = NSPredicate(format: "idProducto = \(IdProducto)", IdProducto)
      
        do{
            let resultFetch = try context.fetch(response) as! [NSManagedObject]
            let producto = resultFetch.first
            context.delete(producto!)
            try context.save()
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }

        return result
    }
    func GetById(_ IdProducto : Int)-> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        
        //let predicate = NSPredicate(format: "idProducto = %@", String(IdAlumno))
               
               let predicate = NSPredicate(format: "idProducto = %i", IdProducto)
               
               response.predicate = predicate
        
        do{
            try context.save()
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }

        return result
        
    }
    func GetAll() -> Result{
        var result = Result()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        
        do{
            let resultFetch = try context.fetch(response)
            result.Objects = []
            for obj in resultFetch as! [NSManagedObject]{
                
               let ventaProducto = Venta()
                
                               
                ventaProducto.producto = Producto()
                               ventaProducto.producto?.IdProducto = obj.value(forKey: "idProducto") as! Int
                ventaProducto.Cantidad = obj.value(forKey: "cantidad") as! Int
                               let resultGetById = ProductoViewModel.GetById(IdProducto: ventaProducto.producto?.IdProducto as! Int)
                               if resultGetById.Correct! {
                                   let producto = resultGetById.Object! as! Producto
                                   
                                   ventaProducto.producto?.Nombre = producto.Nombre
                                   ventaProducto.producto?.PrecioUnitario = producto.PrecioUnitario
                                   ventaProducto.producto?.Imagen = producto.Imagen
                                   result.Objects?.append(ventaProducto)
                               }
                               
            }
            result.Correct = true
        }
        
      
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        
        return result
    }
    
    func UpdateCantidad(_ IdProducto : Int, _ cantidad: Int)-> Result{
        var result = Result()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
        
               
     response.predicate = NSPredicate(format: "idProducto = %@" , String(IdProducto))
  //  let predicate = NSPredicate(format: "idProducto = %i" , String(IdProducto))
        
               
        // response.predicate = predicate
        
            
        
        do{
            let resultFetch = try context.fetch(response)
            
            let producto = resultFetch[0] as! NSManagedObject
           // producto.setValue(IdProducto, forKey: "idProducto")
            producto.setValue(cantidad, forKey: "cantidad")
            try context.save()
            result.Correct = true
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }

        return result
        
    }
}

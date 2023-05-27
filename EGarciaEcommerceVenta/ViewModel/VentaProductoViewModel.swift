//
//  VentaProductoViewModel.swift
//  EGarciaEcommerceVenta
//
//  Created by MacBookMBA4 on 25/05/23.
//

import Foundation
import CoreData

class VentaProductoViewModel{
    //referencia
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "EGarciaEcommerce")
           container.loadPersistentStores { description, error in
               if let error = error {
                   fatalError("Unable to load persistent stores: \(error)")
                   //Propio error
               }
           }
           return container
       }()

    
    //context
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext

        }()

    func createData() {
           
            guard let userEntity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context) else { return }
            for i in 1...5 {
                let producto =  NSManagedObject(entity: userEntity, insertInto: context)
                producto.setValue(1, forKey: "cantidad")
                producto.setValue(20, forKey: "idProducto")

            }
            do {
                try context.save()
                debugPrint("Data saved")
            } catch let error as NSError {
                debugPrint(error)
            }
        }
    func GetAll() {
           
       
            let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")

            do {
                guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                    return
                }
                debugPrint("Saved values")
                for producto in result {
                    debugPrint(producto.value(forKey: "cantidad") as? String ?? "")
                }
            } catch let error as NSError {
                debugPrint(error)
            }
        }
    func updateData() {
           
         
            let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "VentaProducto")
            fetchRequest.predicate = NSPredicate(format: "cantidad = %@", "2")
            do {
                guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                    return
                }
                guard let objc = result.first else { return }
                objc.setValue("2", forKey: "cantidad")
                do {
                    try context.save()
                    debugPrint("Data Updated")
                } catch let error as NSError {
                    debugPrint(error)
                }
            } catch let error as NSError {
                debugPrint(error)
            }
        }
    func deleteData() {
           
            let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ventaproducto")
            fetchRequest.predicate = NSPredicate(format: "cantidad = %", "2")
            do {
                guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else {
                    return
                }
                guard let objc = result.first else { return }
                context.delete(objc)
                do {
                    try context.save()
                    debugPrint("Record deleted")
                } catch let error as NSError {
                    debugPrint(error)
                }
            } catch let error as NSError {
                debugPrint(error)
            }
        }

  
  

}//class

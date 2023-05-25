
//  GetAllUsuarioController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 03/05/23.
//

import UIKit
import SwipeCellKit

class GetAllUsuarioController: UITableViewController {
    
    var usuarios : [Usuario] = []
    let dbManager = DBManager()
    var result = Result()
    var IdUsuario : Int = 0, IdRol : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName :"UsuarioCell", bundle: .main), forCellReuseIdentifier: "UsuarioCell")
        updateUI()
     
    }
    override func viewWillDisappear(_ animated: Bool) {
      print("apunto de desaparecer: WillDisapear GetAll")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("apunto de aparecer:  WillApear GetAll")
        IdUsuario = 0
        tableView.reloadData()
        self.updateUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("desaparece la vista DidDisapear GetAll")
    }
    override func viewDidAppear(_ animated: Bool) {
      print("aparecio la vista : DidAppear GetAll")
    }
    
    
    
    
   
    @IBAction func btnSalir(_ sender: UIButton) {
        performSegue(withIdentifier: "SalirSegue", sender: self)
    }
    
    
    // MARK: - Table view data source
    func updateUI(){
        var result = UsuarioViewModel.GetAll()
        usuarios.removeAll()
        if result.Correct!{
            for objUsuario in result.Objects!{
                let usuario = objUsuario as! Usuario //Unboxing
                usuarios.append(usuario)
            }
            tableView.reloadData()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "FormController"{
                let formControl = segue.destination as! FormController
                formControl.IdUsuario = self.IdUsuario
                
            }
   
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioCell
        // print("El index actual es: \(indexPath.row)")
        
        cell.delegate = self
        
        cell.txtNombreOutlet.text = "Nombre: \(usuarios[indexPath.row].Nombre!)"
        cell.txtApellidoPaterno.text = "ApellidoPaterno: \(usuarios[indexPath.row].ApellidoPaterno!)"
       // cell.txtID.text = "ID: \(String(usuarios[indexPath.row].IdUsuario!))"
        cell.txtFechaNacimientoOutlet.text = "FechaNacimiento: \(usuarios[indexPath.row].FechaNacimiento!)"
        cell.txtUserNameOutlet.text = "Username: \(usuarios[indexPath.row].UserName!)"
       
        //cell.txtIdRol.text = String(usuarios[indexPath.row].Rol!.IdRol!)
        cell.txtIdRol.text = "Rol: \(usuarios[indexPath.row].Rol!.Nombre!)"
        
       
        
        
        
        
        // Configure the cell...
        
        return cell
        
    }
    //class
}
        
extension GetAllUsuarioController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                //print(indexPath.row)
                
                //CODIGO A EJECUTAR
                
            let result = UsuarioViewModel.Delete(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                if result.Correct!{
                    print("Usuario Eliminado")
                    self.updateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            
            deleteAction.image = UIImage(named: "trash")
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                //print("Se ejecuto la funcion de update")
                //CODIGO A EJECUTAR
  
                 
                var result = UsuarioViewModel.GetById(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                self.performSegue(withIdentifier: "FormController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
  
  
}


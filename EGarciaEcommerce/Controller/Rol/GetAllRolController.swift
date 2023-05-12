//
//  GetAllRolController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 09/05/23.
//

import UIKit
import SwipeCellKit
//MARK: GetAllRolController
class GetAllRolController: UIViewController{

    var roles : [Rol] = []
    var tableView: UITableView = UITableView()
    @IBOutlet weak var RolTableView: UITableView!
    let dbManager = DBManager()
    var result = Result()
    var IdRol : Int = 0, IdUsuario : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        RolTableView.register(UINib(nibName :"RolCell", bundle: .main), forCellReuseIdentifier: "RolCell")
        RolTableView.dataSource = self
        RolTableView.delegate = self
        updateUI()
       
    }
    override func viewWillDisappear(_ animated: Bool) {
      print("apunto de desaparecer: WillDisapear GetAll")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("apunto de aparecer:  WillApear GetAll")
        IdRol = 0
        RolTableView.reloadData()
        self.updateUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("desaparece la vista DidDisapear GetAll")
    }
    override func viewDidAppear(_ animated: Bool) {
      print("aparecio la vista : DidAppear GetAll")
    }
    func updateUI(){
        var result = RolViewModel.GetAll()
        roles.removeAll()
        if result.Correct!{
            for objRol in result.Objects!{
                let rol = objRol as! Rol //Unboxing
                roles.append(rol)
            }
            RolTableView.reloadData()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "FormRolController"{
                let formControl = segue.destination as! FormRolController
                formControl.IdRol = self.IdRol
                
            }
       
        }

        }




//MARK: SwipeCell
extension GetAllRolController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                //print(indexPath.row)
                
                //CODIGO A EJECUTAR
                
                var result = RolViewModel.Delete(IdRol: self.roles[indexPath.row].IdRol!)
                
                if result.Correct!{
                    print("Usuario Eliminado")
                    self.updateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            
            //deleteAction.image = UIImage(named: "trash")
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                //print("Se ejecuto la funcion de update")
                //CODIGO A EJECUTAR
  
        
               // var result = UsuarioViewModel.GetById(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                self.IdRol = self.roles[indexPath.row].IdRol!
                self.performSegue(withIdentifier: "FormRolController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
  
}
//MARK: UITableViewDataSource.UITableViewDelegate
extension GetAllRolController : UITableViewDataSource,UITableViewDelegate{


    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections


        return 1
   }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of rows
       return roles.count
   }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {



       let cell = tableView.dequeueReusableCell(withIdentifier: "RolCell", for: indexPath) as! RolCell
       // print("El index actual es: \(indexPath.row)")

       cell.delegate = self
        cell.txtNombre.text = roles[indexPath.row].Nombre


        cell.txtIdRol.text = String(roles[indexPath.row].IdRol!)



       return cell

   }
}


//
//  DepartamentoController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 23/05/23.
//

import UIKit

 
class DepartamentoController: UICollectionViewController {

     
    var IdDepartamento : Int = 0
    let dbManager = DBManager()
    var result = Result()
    var IdArea : Int = 0
    var departamentos : [Departamento] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
              collectionView.delegate = self
              collectionView.dataSource = self
              
              //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AreaDepartamentoCell")
              collectionView.register(UINib(nibName :"AreaDepartamentoCell", bundle: .main), forCellWithReuseIdentifier: "AreaDepartamentoCell")
              updateUI()
              

    
    }
    func updateUI(){
        var result = DepartamentoViewModel.GetByArea(IdArea: IdArea)
        departamentos.removeAll()
        if result.Correct!{
            for objDepartamento in result.Objects!{
                let departamento = objDepartamento as! Departamento //Unboxing
                departamentos.append(departamento)
            }
            collectionView.reloadData()
        }
        
    }
  
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return departamentos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "AreaDepartamentoCell", for: indexPath)  as! AreaDepartamentoCell

        cell.imageViewAreaDepartamento.image = UIImage(named: departamentos[indexPath.row].Nombre!)
        cell.lblNombre.text = departamentos[indexPath.row].Nombre!
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        IdDepartamento = departamentos[indexPath.row].IdDepartamento!
        print(departamentos[indexPath.row].IdDepartamento!)
        print(IdDepartamento)
        self.performSegue(withIdentifier: "DepartamentoProductoSegue", sender: self)
        
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "DepartamentoProductoSegue" {
                let formControl = segue.destination as! ProductoCollectionController
                formControl.IdDepartamento = self.IdDepartamento
                
            }
   
        }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


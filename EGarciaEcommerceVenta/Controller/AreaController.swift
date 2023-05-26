//
//  AreaController.swift
//  EGarciaEcommerce
//
//  Created by MacBookMBA4 on 23/05/23.
//

import UIKit

class AreaController: UIViewController {
    
    let dbManager = DBManager()
    var result = Result()
    var IdArea : Int = 0
    var areas : [Area] = []
    var color = UIColor.red.cgColor
    var color2 = UIColor.white.cgColor
    var nombreProducto : String? = nil
    //var collectionView: UICollectionView = UICollectionView()
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var txtBuscar: UITextField!
    // private let cellId = "DepartamentoAreaCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AreaDepartamentoCell")
        collectionView.register(UINib(nibName :"AreaDepartamentoCell", bundle: .main), forCellWithReuseIdentifier: "AreaDepartamentoCell")
        updateUI()
        
 
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("apunto de desaparecer: WillDisapear GetAll")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("apunto de aparecer:  WillApear GetAll")
        IdArea = 0
        collectionView.reloadData()
        self.updateUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("desaparece la vista DidDisapear GetAll")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("aparecio la vista : DidAppear GetAll")
    }
    
    @IBAction func btnBuscar(_ sender: Any) {
        
        //txtBuscar.text = nombreProducto
        nombreProducto = txtBuscar.text
        print(nombreProducto)
        guard txtBuscar.text != "" else{
                   
            txtBuscar.layer.borderColor = color
            txtBuscar.layer.borderWidth = 1.0
                   return
               }
        txtBuscar.layer.borderColor = color2
        txtBuscar.layer.borderWidth = 1.0
        
     //   var result = ProductoViewModel.GetByName(nombreProducto: nombreProducto!)
        //self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
        self.performSegue(withIdentifier: "AreaProductoSegue", sender: self)
    }
    
    func updateUI(){
        var result = AreaViewModel.GetAll()
        areas.removeAll()
        if result.Correct!{
            for objArea in result.Objects!{
                let area = objArea as! Area //Unboxing
                areas.append(area)
            }
            collectionView.reloadData()
        }
        
    }
    
    
    
}

//MARK: extension collection datasource
extension AreaController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "AreaDepartamentoCell", for: indexPath)  as! AreaDepartamentoCell
        
        
        //cell.delegate = self
        cell.imageViewAreaDepartamento.image = UIImage(named: areas[indexPath.row].Nombre!)
        cell.lblNombre.text = areas[indexPath.row].Nombre!
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(areas.count)
        return areas.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        IdArea = areas[indexPath.row].IdArea!
        print(areas[indexPath.row].IdArea!)
        print(IdArea)
        self.performSegue(withIdentifier: "AreaDepartamentoSegues", sender: self)
        
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //controlar que hacer antes de ir a la siguiente vista
            if segue.identifier == "AreaDepartamentoSegues" {
                let formControl = segue.destination as! DepartamentoController
                formControl.IdArea = self.IdArea
                
            }
            if segue.identifier == "AreaProductoSegue"{
                let formControl = segue.destination as! ProductoCollectionController
                formControl.nombreProducto = self.nombreProducto!
            }
   
        }
    
    
    
    //MARK: extension collection cell delegate
    //extension AreaController: UICollectionViewDelegate {
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        print(indexPath.item)
    //    }
    //}
    
    
    //MARK: extension collection delegateflowlayour ajusta el tamaño de la celda
    
    //extension AreaController: UICollectionViewDelegateFlowLayout {
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: view.frame.width, height: 200)
    //    }
    //}
}


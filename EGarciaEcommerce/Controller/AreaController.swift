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
    @IBOutlet weak var collectionDepartamentoArea: UICollectionView!
    
    private let cellId = "DepartamentoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionDepartamentoArea.delegate = self
        collectionDepartamentoArea.dataSource = self
        collectionDepartamentoArea.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)

    }
    override func viewWillDisappear(_ animated: Bool) {
      print("apunto de desaparecer: WillDisapear GetAll")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("apunto de aparecer:  WillApear GetAll")
        //IdUsuario = 0
       // tableView.reloadData()
       // self.updateUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("desaparece la vista DidDisapear GetAll")
    }
    override func viewDidAppear(_ animated: Bool) {
      print("aparecio la vista : DidAppear GetAll")
    }
    
    

  

}

//MARK: extension collection datasource
extension AreaController: UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
return 5
}
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
cell.backgroundColor = .red
return cell
}
}

//MARK: extension collection cell delegate
extension AreaController: UICollectionViewDelegate {
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
print(indexPath.item)
}
}


//MARK: extension collection delegateflowlayour ajusta el tamaño de la celda

extension AreaController: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
return CGSize(width: view.frame.width, height: 200)
}
}

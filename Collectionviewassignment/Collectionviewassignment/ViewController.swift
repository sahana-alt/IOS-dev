//
//  ViewController.swift
//  Collectionviewassignment
//
//  Created by Sahana B on 22/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    var imgmanager = ImageManager()
    var imagemodel = [ImageModel]()
    
    let url = "https://api.unsplash.com/search/photos?page=1&query=work%20from%20home&client_id=41cdff6622cbdd2d162fcd23765bd48b70d7af474e346a1cab819c5744056b79"
    override func viewDidLoad() {
        super.viewDidLoad()
        imgmanager.delegate = self
        imgmanager.performRequest(urlString: url)
        DispatchQueue.main.asyncAfter(deadline: .now()+1){ [self] in
        
        CollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
            self.CollectionView.delegate=self
        CollectionView.dataSource=self
            let layout = UICollectionViewFlowLayout()
            
            layout.itemSize = CGSize(width: self.view.frame.width/3-3, height: self.view.frame.height/3-3)

            self.CollectionView.collectionViewLayout = layout
        }
    
        // Do any additional setup after loading the view.
    }
    
    
    
    
}

extension ViewController: UICollectionViewDelegate{
    
}
extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagemodel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        
        let row = indexPath.row
        
        cell.ImgView.load(url: URL(string: imagemodel[row].url)!)
        
        return cell
    }
    
    
}
extension ViewController:ImageManagerDelegate{
    func didUpdateView(_ imageManager: ImageManager, image: [ImageModel]) {
        self.imagemodel = image
    }
    
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 120, height: 120)

        

    }

}

//
//  ImageManager.swift
//  Collectionviewassignment
//
//  Created by Sahana B on 22/04/21.
//

import Foundation
protocol ImageManagerDelegate {
    func didUpdateView(_ imageManager: ImageManager, image: [ImageModel])
    
}


struct  ImageManager {
   
    var delegate: ImageManagerDelegate?
    func  performRequest(urlString:String)  {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
                        let task = session.dataTask(with: url) { (data, response, error) in
                            if error != nil {
                                
                                return
                            }
                            if let safeData = data {
                                if let images = self.parseJSON(safeData) {
                                    self.delegate?.didUpdateView(self, image: images)
                                    
                                }
                            }
                        }
            task.resume()
        }
    }
    
    func parseJSON(_ imageData: Data) -> [ImageModel]?{

            let decoder = JSONDecoder()

            var imagesData = [ImageModel]()

            do{

                let decodedData = try decoder.decode(ImageData.self, from: imageData)

                let result = decodedData.results
                
                

                for i in 0..<result.count{

                    imagesData.append(ImageModel(url: result[i].urls.thumb))

                  //  imagesData.append(ImageModel(imageUrl: result[i].urls.full))

                }
               return imagesData
                


                



            } catch{

                
                return nil

            }

        }
        
        
        
}

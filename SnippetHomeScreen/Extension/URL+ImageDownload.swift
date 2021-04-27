//
//  URL+ImageDownload.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 24/04/21.
//

import Foundation
import UIKit
extension UIImageView {
    func imageFromUrl(urlString: String, handler : ((Bool)-> Void)?) -> URLSessionDataTask? {
        self.image = UIImage(named: "thumbnail")
        if let url = URL(string: urlString) {
            //checking in the file manager
            if let cachedImage = ImageViewerDataSource.shared.getImage(id: urlString ) {
                self.image = cachedImage.imageWith(newSize: CGSize(width: 200, height: 200))
                handler?(true)
                return nil
            }
            //if not in file manager then go for downloading the image from url
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if let imageData = data {
                    if let downloadedimage = UIImage(data: imageData){
                        DispatchQueue.main.async {
                            let image = downloadedimage.imageWith(newSize: CGSize(width: 200, height: 200))
                            self.image = image
                            handler?(true)
                        }
                        ImageViewerDataSource.shared.saveImageDocumentDirectory(id: urlString, image: downloadedimage)
                    }
                }else{
                    handler?(false)
                }
            }
            task.resume()
            return task
        }
        return nil
    }
}

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        
        return image.withRenderingMode(self.renderingMode)
    }
}


class ImageViewerDataSource {
    static var shared = ImageViewerDataSource()
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            //print("Already dictionary created.")
        }
    }
    func getImage(id: String)-> UIImage?{
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(id.toBase64())
        if fileManager.fileExists(atPath: imagePAth){
            return UIImage(contentsOfFile: imagePAth)
        }else{
            //print("No Image")
            return nil
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveImageDocumentDirectory(id: String, image: UIImage){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(id.toBase64())
        //print(paths)
        let imageData = image.jpegData(compressionQuality: 1)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
}

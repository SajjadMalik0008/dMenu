//
//  SliderImages.swift
//  DMenu
//
//  Created by Muhammad Sajjad on 16/10/2020.
//
import UIKit
import Foundation

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

struct slider: Decodable{
    let img: String
    let name: String
  
}


//var ImageArray = [  UIImage(named:"slider_img3"),
//                    UIImage(named:"slider_img2") ,
//                    UIImage(named:"slider_img1") ,
//                    UIImage(named:"Angelina Jolie") ,
//                    UIImage(named:"img_sandwich") ,
//                    UIImage(named:"Angelina Jolie") ,
//                    UIImage(named:"img_sandwich") ,
//                    UIImage(named:"img_sandwich") ,
//                    UIImage(named:"img_sandwich") ,
//                    UIImage(named:"img_sandwich") ]
//var imageArrayNames = ["item_defualt","slider_img3","item_defualt","slider_img3","item_defualt","slider_img3","item_defualt","img_sandwich","slider_img1","slider_img3"]

//
//  RocketCollectionViewCell.swift
//  SpaceX_Arabam.com
//
//  Created by Selay Soysal on 4.03.2018.
//  Copyright © 2018 Selay Turkmen. All rights reserved.
//

import UIKit

class RocketCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    @IBOutlet weak var rocketLaunchDateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let imageSession = URLSession(configuration: .ephemeral)
    
    let cache = NSCache<NSURL, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderWidth = 0.8
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func loadImage(from imageUrl: String, completion: @escaping (UIImage) -> Void)
    {
        let url = URL(string:imageUrl)
        if let image = cache.object(forKey: url! as NSURL)
        {
            completion(image)
        }
        else
        {
            let task = imageSession.dataTask(with: url!) { (imageData, _, _) in
                guard let imageData = imageData,
                    let image = UIImage(data: imageData)
                    else { return }
                
                self.cache.setObject(image, forKey: url! as NSURL)
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
            task.resume()
        }
    }
    
    func displayData(name:String ,type:String, dateOfLaunch:String, imageURL:String) {
       
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
    
        let date = dateFormatter.date(from: dateOfLaunch.components(separatedBy: "T")[0])
        rocketNameLabel.text = name
        rocketTypeLabel.text = type
        rocketLaunchDateLabel.text = dateFormatter.string(from: date!)
        
        loadImage(from: imageURL) {
            self.imageView.image = $0
        }
    }
}


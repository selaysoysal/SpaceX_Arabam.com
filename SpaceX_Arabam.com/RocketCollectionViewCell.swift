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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func displayData(name:String? ,type:String?, date:String?, imageURL:String?) {
       
        rocketNameLabel.text = name
        rocketTypeLabel.text = type
        rocketLaunchDateLabel.text = date
        if (imageURL != nil) {
            imageView.imageFromURL(urlString: imageURL!)
            
        }
    }
}


extension UIImageView {
    public func imageFromURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

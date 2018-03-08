//
//  LaunchDetailViewController.swift
//  SpaceX_Arabam.com
//
//  Created by Selay Soysal on 4.03.2018.
//  Copyright © 2018 Selay Turkmen. All rights reserved.
//

import UIKit
import SafariServices

class LaunchDetailViewController: UIViewController, SFSafariViewControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var videoLink: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleLink: UIButton!

    
    var launches = [Launches()]
    var index = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(index)
        
        self.updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func updateUI()
    {
        
        videoLink.titleLabel?.text = "Watch me on Youtube!"
        articleLink.titleLabel?.text =  "Read about me!"
       
        titleLable.text = launches[index].rocket?.rocket_name
        titleLable.font = UIFont.boldSystemFont(ofSize: 17)
        
        descriptionLabel.text = launches[index].details?.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.sizeToFit()
        descriptionLabel.setNeedsLayout()
    }
    
    @IBAction func goToVideo(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string:(launches[index].links?.article_link)!)!, entersReaderIfAvailable: true)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func goToArticle(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string:(launches[index].links?.video_link)!)!, entersReaderIfAvailable: true)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

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
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        self.updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                if index != 0 {
                    index -= 1
                } else {
                    return
                }
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                if index == launches.count-1{
                    return
                } else {
                    index += 1
                }
            default:
                break
            }
             updateUI()
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    func updateUI()
    {
        
        videoLink.setTitle("Watch me on Youtube!", for: UIControlState.normal)
        articleLink.setTitle("Read about me!", for: UIControlState.normal)
       
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

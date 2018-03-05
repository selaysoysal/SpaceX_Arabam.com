//
//  LaunchDetailViewController.swift
//  SpaceX_Arabam.com
//
//  Created by Selay Soysal on 4.03.2018.
//  Copyright © 2018 Selay Turkmen. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var videoLink: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var launches = [Launches()]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(index)
        self.loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadData()
    {
        let myURLString = launches[index].links?.article_link
        guard let myURL = URL(string: myURLString!) else {
            print("Error: \(String(describing: myURLString)) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            print("HTML : \(myHTMLString)")
            webView.loadHTMLString(myHTMLString, baseURL: myURL)
        } catch let error {
            print("Error: \(error)")
        }
        
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

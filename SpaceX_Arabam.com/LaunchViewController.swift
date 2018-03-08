//
//  LaunchViewController.swift
//  SpaceX_Arabam.com
//
//  Created by Selay Soysal on 8.03.2018.
//  Copyright © 2018 Selay Turkmen. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 2,
                             target: self,
                             selector: #selector(self.showView),
                             userInfo: nil,
                             repeats: true)
       
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showView(){
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "launch", sender: self)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    */

}

//
//  ListViewController.swift
//  SpaceX_Arabam.com
//
//  Created by Selay Soysal on 4.03.2018.
//  Copyright © 2018 Selay Turkmen. All rights reserved.
//

import UIKit

class ListViewController: ViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var pickerViewContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filterButton    : UIBarButtonItem! = nil
    var sortButton      : UIBarButtonItem! = nil
    var clearButton     : UIBarButtonItem! = nil
    
    var filterArray = ["Filter by Rocket Type", "Filter by Name", "Filter by Launch Site", "Filter by Launch Year"]
    var pickerArray = Array<String>()
    var filterType: String = ""
    var filter: String = ""
    var isDataFiltered: Bool = false
    var isOrderAsc: Bool = false
    var launches = [Launches()]
    var filteredLaunches = [Launches()]
    var sortedLaunches = [Launches()]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadData()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isHidden = true
        
        self.filterTableView.dataSource = self
        self.filterTableView.delegate = self
        self.blurView.isHidden = true
        
        self.pickerViewContainerView.isHidden = true
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
    
       filterButton = UIBarButtonItem(image: UIImage(named: "filter"),style: .plain, target: self, action: #selector(filterRockets))
        
        sortButton = UIBarButtonItem(image: UIImage(named: "descendant"),style: .plain, target:self, action: #selector(sortRockets))
        
        clearButton = UIBarButtonItem(image: UIImage(named: "rubbish-bin"), style: .plain, target: self, action: #selector(clearFilters))

        self.navigationItem.rightBarButtonItems = [sortButton,filterButton]
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.size.width/3.2), height:(self.view.frame.size.width/3.2)*2)
        self.collectionView.collectionViewLayout = layout;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sortRockets(sender: UIBarButtonItem)
    {
        if isOrderAsc {
            launches = launches.sorted(by:{ $0.launch_date_utc! > $1.launch_date_utc!})
            filteredLaunches = filteredLaunches.sorted(by:{ $0.launch_date_utc! > $1.launch_date_utc!})
        } else {
            launches = launches.sorted(by:{ $1.launch_date_utc!  > $0.launch_date_utc! })
             filteredLaunches = filteredLaunches.sorted(by:{ $1.launch_date_utc!  > $0.launch_date_utc! })
        }
        isOrderAsc = !isOrderAsc
        collectionView.reloadData()
    }
    
    @objc func clearFilters(sender: UIBarButtonItem)
    {
        self.navigationItem.rightBarButtonItems = [sortButton,filterButton]
        self.isDataFiltered = false
        self.blurView.isHidden = true
        self.loadData()
    }
    
    @objc func filterRockets(sender: UIBarButtonItem) {
        self.blurView.isHidden = false
        self.navigationItem.rightBarButtonItems = [sortButton,clearButton]
    }
    
    
    @IBAction func doneAction(_ sender: Any)
    {
        self.filterData()
        self.isDataFiltered = true
        self.pickerViewContainerView.isHidden = true
        self.blurView.isHidden = true
    }
    
    func loadData()
    {
        APIAdapter().getLaunches(completion:  {data in
                do {
                    let decoder = JSONDecoder()
                    self.launches = try decoder.decode([Launches].self, from: data)
                   
                    self.collectionView.isHidden = false
                    self.collectionView.reloadData()
                } catch let err {
                    print("Err", err)
                }
    
            print("Done🔨") })
        
    }
    
    func filterData()
    {
        self.filteredLaunches.removeAll()
        
        switch self.filterType {
        case "Filter by Rocket Type":
            for i in launches{
                if i.rocket?.rocket_type == filter {
                    self.filteredLaunches.append(i)
                }
            }
        case "Filter by Name":
            for i in launches{
                if i.rocket?.rocket_name == filter {
                    self.filteredLaunches.append(i)
                }
            }
        case "Filter by Launch Site":
            for i in launches{
                if i.launch_site?.site_name_long == filter {
                    self.filteredLaunches.append(i)
                }
            }
        case "Filter by Launch Year":
            for i in launches{
                if i.launch_year == filter {
                    self.filteredLaunches.append(i)
                }
            }
        default:
            break
        }
        self.collectionView.reloadData()
    }

    //MARK:TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")!
        cell.textLabel?.text = filterArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.pickerArray.removeAll()
        var filterSet = Set<String>()
        switch filterArray[indexPath.row] {
            case "Filter by Rocket Type":
                for i in launches{
                    filterSet.insert((i.rocket?.rocket_type)!)
                }
            case "Filter by Name":
                for i in launches{
                    filterSet.insert((i.rocket?.rocket_name)!)
                }
            case "Filter by Launch Site":
                for i in launches{
                    filterSet.insert((i.launch_site?.site_name_long)!)
                }
            case "Filter by Launch Year":
                for i in launches{
                    filterSet.insert((i.launch_year)!)
                }
            default:
                break
        }
        self.filterType = filterArray[indexPath.row]
        self.pickerArray = Array(filterSet)
        self.pickerView.reloadAllComponents()
        
        self.pickerViewContainerView.isHidden = false
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //MARK: collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (!isDataFiltered && launches.count > 0 ){
            return launches.count
        } else if (isDataFiltered && filteredLaunches.count > 0 ){
            return filteredLaunches.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rocketCell",
                                                      for: indexPath) as! RocketCollectionViewCell
        var launch = Launches()
        if isDataFiltered {
            launch = self.filteredLaunches[indexPath.row]
        } else {
            launch = self.launches[indexPath.row]
        }
        if (launch.launch_date_utc != nil && launch.rocket?.rocket_name != nil && launch.rocket?.rocket_type != nil && launch.links?.mission_patch != nil) {
            cell.displayData(name:(launch.rocket?.rocket_name)! , type: (launch.rocket?.rocket_type)!, dateOfLaunch: launch.launch_date_utc!, imageURL: (launch.links?.mission_patch)!)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LaunchDetailViewController") as! LaunchDetailViewController
        vc.launches = launches
        vc.index = indexPath.row
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }

    
    //MARK: pickerView
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.filter = pickerArray[row]
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

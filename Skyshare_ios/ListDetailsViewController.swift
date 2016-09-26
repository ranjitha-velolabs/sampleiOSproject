//
//  ListDetailsViewController.swift
//  Skyshare_ios
//
//  Created by Ranjitha on 9/25/16.
//  Copyright © 2016 Ranjitha. All rights reserved.
//

import UIKit

class ListDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    // declare the array for getting the list of details in MapViewcontroller
     var listDetailsArray = [String]() as NSArray
    
    

    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! ListDetailsTableViewCell
        let val:NSDictionary = (listDetailsArray[indexPath.row] as? NSDictionary)!
        cell.distance_Lbl.text = (val["distance"] as? String)!+"|"+(val["time"] as? String)!
        //cell.time_Lbl.text = val["time"] as? String
        cell.fleet_name_Lbl.text = val["fleet name"] as? String
        cell.description_Lbl.text = val["description"] as? String
        
        cell.rate_Lbl.text = "$"+(val["rate"] as? String)!
        
        cell.label_count_Lbl.text = val["labelCount"] as? String
        return cell
    }
    
    
  // func numberOfSections(in tableView: UITableView) -> Int {
      //  <#code#>
    //}
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDetailsArray.count
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

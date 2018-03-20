//
//  SearchScreenViewController.swift
//  M4C
//
//  Created by Kalpesh Satasiya on 19/03/18.
//  Copyright © 2018 Kalpesh Satasiya. All rights reserved.
//

import UIKit

class SearchScreenViewController: UIViewController {

    var homedata:[NSDictionary] = []
    var data = [String]()
    
    var filteredData: [String]!

    @IBOutlet var tblSearchData: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        filteredData = data

        print(filteredData)


    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController? .popViewController(animated: false)
    }
}

extension SearchScreenViewController:UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SearchTableViewCell
        cell?.lblTtile.text = filteredData[indexPath.row]
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tblSearchData.reloadData()
    }
    
}




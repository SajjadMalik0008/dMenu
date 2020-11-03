//
//  ListOfItemsViewController.swift
//  DMenu
//
//  Created by Muhammad Sajjad on 26/10/2020.
//

import UIKit

class ListOfItemsViewController: UIViewController {
   
    //@IBOutlet weak var serveIconView: UIView!
    @IBOutlet weak var listItemTableView: UITableView!
    var catId :Int = 0
    var countOfItem: Int = 0
    var objOfStructListItems = [listItems]()
    override func viewDidLoad() {
    print("catid= \(catId)")
        super.viewDidLoad()
        
        
        listItemTableView.delegate = self
        listItemTableView.dataSource = self
        
        getListOfItemsData()
        
    }
    
    func getListOfItemsData(){
        let listUrl = URL(string: "https://dmenu-aff64.firebaseio.com/item/Items.json")
        URLSession.shared.dataTask(with: listUrl!) { (data, responce, error) in
            if error == nil {
                do{
                    let allListItems = try JSONDecoder().decode([listItems].self, from: data!)
                    self.objOfStructListItems = allListItems.filter({ (item) -> Bool in
                        return item.cat_id == self.catId
                    })
                }catch  {
                    print("error\(error)")
                }
                DispatchQueue.main.async {
                    self.listItemTableView.reloadData()
                }
            }
            
        }.resume()
       // getCountOfItem()
    }
    
    func getCountOfItem(){
       print(objOfStructListItems.count)
        for i in  1...objOfStructListItems.count {
            if catId == objOfStructListItems[i].cat_id{
            countOfItem += 1
            }
        }
    }
}


extension ListOfItemsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // getCountOfItem()
        //print("hfvfh hvfbv  \(objOfStructListItems.count)")
        return objOfStructListItems.count
      
      }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListOfItem
            cell.itemName.text = objOfStructListItems[indexPath.row].name
            cell.serveIconView.layer.cornerRadius = 15
            cell.deliverTime.text = objOfStructListItems[indexPath.row].serving_time
            cell.itemRecipe.text = objOfStructListItems[indexPath.row].recipe
            cell.price.text = objOfStructListItems[indexPath.row].price
            cell.noOfOrders.text = objOfStructListItems[indexPath.row].order_count
            cell.noOfPerson.text = objOfStructListItems[indexPath.row].no_of_person
            cell.size.text = objOfStructListItems[indexPath.row].size
            let imgLink =  objOfStructListItems[indexPath.row].img
            cell.itemListImage.downloaded(from: imgLink)
            cell.itemListImage.contentMode = .scaleAspectFill
            cell.itemListImage.clipsToBounds = true
            cell.size.transform = CGAffineTransform(rotationAngle: 24.8)
            cell.price.transform = CGAffineTransform(rotationAngle: 24.8)
            return cell
    }
    
}

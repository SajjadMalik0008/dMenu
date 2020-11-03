//
//  ListOfItem.swift
//  DMenu
//
//  Created by Muhammad Sajjad on 26/10/2020.
//

import UIKit

struct listItems:Decodable {
    let cat_id: Int
    let item_id: Int
    let img: String
    let name: String
    let recipe: String
    let no_of_person: String
    let order_count: String
    let size: String
    let serving_time: String
    let price: String
}

class ListOfItem: UITableViewCell {
    
    @IBOutlet weak var itemListImage: UIImageView!
    @IBOutlet weak var serveIconView: UIView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var deliverTime: UILabel!
    @IBOutlet weak var itemRecipe: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var noOfOrders: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var noOfPerson: UILabel!
}

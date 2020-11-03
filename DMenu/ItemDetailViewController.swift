//
//  ItemDetailViewController.swift
//  DMenu
//
//  Created by Muhammad Sajjad on 29/10/2020.
//

import UIKit

class ItemDetailViewController: UIViewController {
    @IBOutlet weak var orderButtonView: UIView!
    
    @IBOutlet weak var sizePriceStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderButtonView.layer.cornerRadius = 25
        sizePriceStackView.layer.borderWidth = 1
        //sizePriceStackView.layer.borderColor = ("#F36E07" as! CGColor)
        
    }
    @IBAction func orderButtonPressed(_ sender: Any) {
        print("Button Pressed")
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
    }
    
}

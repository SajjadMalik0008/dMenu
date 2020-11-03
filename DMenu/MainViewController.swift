//
//  ViewController.swift
//  BottomNavigation
//
//  Created by Muhammad Sajjad on 15/10/2020.
//

import UIKit

class MainViewController: UIViewController {
  
    
   
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var imageTextLabel: UILabel!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var imageNameLabel: UILabel!
    
    
    
    var menuOut = false
    var timer = Timer()
    var counter = 0
    //let id = itemStructObj[indexPath.row].id
    var id:Int = 0
    //@IBOutlet weak var itemNameLbl: UILabel!
    var sliderStructObj = [slider]()
    var itemStructObj = [items]()
    var obj: ItemsCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.numberOfPages = 4
        pageView.currentPage = 0
        
       // itemNameLbl.layer.cornerRadius = 5
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        
      
        
        getSliderData()
        getItemsData()
       
        
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
//        }
        
    }
    
    
    
    //get slider data from server
    func getSliderData(){
        let sliderUrl = URL(string: "https://dmenu-aff64.firebaseio.com/categories.json")
        URLSession.shared.dataTask(with: sliderUrl!) { (data, responce, error) in
            if error == nil {
                do{
                    self.sliderStructObj = try JSONDecoder().decode([slider].self, from: data!)
                }catch {
                    print("error")
                }
                DispatchQueue.main.async {
                    self.sliderCollectionView.reloadData()
                }
            }
            
        }.resume()
    }
    // get items data from server
    func getItemsData(){
        let itemsUrl = URL(string: "https://dmenu-aff64.firebaseio.com/item/Catogery.json")
        URLSession.shared.dataTask(with: itemsUrl!) { (data, responce, error) in
            if error == nil {
                do{
                    self.itemStructObj = try JSONDecoder().decode([items].self, from: data!)
                }catch {
                    print("items error")
                }
                DispatchQueue.main.async {
                    self.itemCollectionView.reloadData()
                }
            }
            print(self.itemStructObj.count)
        }.resume()
    }
    
    
    @IBAction func menuTapped(_ sender: Any) {
        
        if menuOut == false{
            leading.constant = 150
            //trailing.constant = -150
            pageView.numberOfPages = 1
            menuOut = true
        }else {
            leading.constant = 0
            //trailing.constant = 0
            pageView.numberOfPages = 4
            menuOut = false
        }
    }
   // left button of slider
    @IBAction func leftSlidePressed(_ sender: Any) {
        if counter == 0{
            counter = sliderStructObj.count
        }
        counter -= 1
        let index = IndexPath.init(item: counter, section: 0)
        self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        pageView.currentPage = counter
        imageNameLabel.text = sliderStructObj[counter].name.capitalized

    }
    
//    right button of slider
    @IBAction func rightSlidePressed(_ sender: Any) {
        if counter == sliderStructObj.count{
            counter = 0
        }
        counter += 1
        let index = IndexPath.init(item: counter, section: 0)
        self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        pageView.currentPage = counter
        imageNameLabel.text = sliderStructObj[counter].name.capitalized
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Auto change slider image
    @objc func changeImage() {
     if counter < sliderStructObj.count {
         let index = IndexPath.init(item: counter, section: 0)
        print(index)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageView.currentPage = counter
        //imageNameLabel.text = imageArrayNames[counter]
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageView.currentPage = counter
         counter = 1
      }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollectionView{
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
            
        } else{
            let size = itemCollectionView.bounds
            return CGSize(width: size.width, height: size.height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension MainViewController: UICollectionViewDelegate ,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.sliderCollectionView{
        pageView.numberOfPages = sliderStructObj.count
        return sliderStructObj.count
        }else{
            return itemStructObj.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.sliderCollectionView{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SliderCollectionView
        imageTextLabel.text = sliderStructObj[indexPath.row].name.capitalized
        let imgLink =  sliderStructObj[indexPath.row].img
        cell.sliderImage.downloaded(from: imgLink)
        cell.sliderImage.contentMode = .scaleAspectFill
        cell.sliderImage.clipsToBounds = true
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemsCollectionView
             cell.itemName.text = itemStructObj[indexPath.row].name.capitalized
             let imgLink =  itemStructObj[indexPath.row].img
             cell.itemImage.downloaded(from: imgLink)
             cell.itemImage.contentMode = .scaleAspectFill
             cell.itemImage.clipsToBounds = true
             cell.itemNameView.layer.cornerRadius = 15
           
             return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

        //self.performSegue(withIdentifier: "SegueToCompute", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as?
                ListOfItemsViewController, let index =
                    itemCollectionView.indexPathsForSelectedItems?.forEach({ (index) in
                        destination.catId = itemStructObj[index.row].id
                    }) {
            //destination.catId = itemStructObj[index.row].id
        }
        
//        let destination = segue.destination as? ListOfItemsViewController
//        let indexPaths = self.itemCollectionView.indexPathsForSelectedItems
//        //print(indexPaths)
//        let indexPath = (indexPaths?[0])! as NSIndexPath
//        //print("fgfg = \(indexPath)")
//        destination?.catId = self.itemStructObj[indexPath.item].id
    }
    
    
}



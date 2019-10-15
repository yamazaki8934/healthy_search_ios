//
//  SelectRestaurantViewController.swift
//  healthy_search_ios
//
//  Created by 山崎浩毅 on 2019/10/12.
//  Copyright © 2019 山崎浩毅. All rights reserved.
//

import UIKit
import Koloda

final class SelectRestaurantViewController: UIViewController {
    
    @IBOutlet private weak var restaurantCardView: KolodaView!
    let imageArray = ["yokoyama", "horinouchi"]
    let nameArray = ["よこやま", "ほりのうち"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantCardView.dataSource = self
        restaurantCardView.delegate = self
    }


}

extension SelectRestaurantViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
}

extension SelectRestaurantViewController: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return 2//images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height - 60)
        
        let restaurantImage = UIImageView()
        restaurantImage.image = UIImage(named: imageArray[index])
        restaurantImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: (UIScreen.main.bounds.height - 60) / 2)
        restaurantImage.contentMode = .scaleAspectFill
        restaurantImage.clipsToBounds = true
        restaurantImage.layer.cornerRadius = 8.0
        view.addSubview(restaurantImage)
        
        let restaurantName = UILabel()
        restaurantName.text = nameArray[index]
        restaurantName.frame = CGRect(x: 0, y: restaurantImage.bounds.maxY + 16, width: UIScreen.main.bounds.width - 32, height: 22)
        restaurantName.textAlignment = .center
        restaurantName.font = UIFont(name: "Avenir Next Condensed", size: 20)
        view.addSubview(restaurantName)
        
        return view
    }
    
//    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)[0] as? OverlayView
//    }
}

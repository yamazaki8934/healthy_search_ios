//
//  SelectRestaurantViewController.swift
//  healthy_search_ios
//
//  Created by 山崎浩毅 on 2019/10/12.
//  Copyright © 2019 山崎浩毅. All rights reserved.
//

import UIKit
import Koloda
import MapKit
final class SelectRestaurantViewController: UIViewController {
    
    @IBOutlet private weak var restaurantCardView: KolodaView!
    let imageArray = ["farmer", "margo", "noni_cafe", "daidokoro"]
    let nameArray = ["Mr.FARMER", "サラダデリMARGO", "タヒチアン ノニ カフェ", "農家の台所"]
    let descriptionArray = ["「畑の伝道師」渡邉明が選んだ自慢のお野菜をふんだんに使い、素材の力を最大限に活かしたサラダやオープンサンド。ヴィーガンやHighプロテインメニュイも。アメリカ西海岸にあるヘルスコンシャスなカフェを思わせる、体が喜ぶお野菜カフェです。4種のデットクスウォーターもフリー。", "マルゴは「自然まるごと、サラダサプリ」をコンセプトとしたサラダデリの専門店です。 自然の恵みである野菜を食の主役に位置付け、国産の旬の野菜を中心にした栄養満点のサラダをご提供します", "都会の喧騒の中に位置しながらも、一歩足を踏み入れるとゆったりとした時間の流れが感じられる空間。明るい日差しが差し込む開放的な店内で、カラダとココロに向き合える時間を過ごしてもらいたいと、タヒチアンノニカフェは考えます。カフェでは「カラダにやさしい」をテーマに、野菜中心のメニュー作りをしています。", "新宿の真ん中でこんなにも新鮮な野菜が食べられるの？！しかも食べ放題？！ありがとうございます。そうなんです。これでもかっ！って野菜摂取ができます。"]
    let tabelogArray = ["https://mr-farmer.jp/locations/", "https://margo.co.jp/", "https://tncafe.jp/", "https://tabelog.com/tokyo/A1304/A130401/13094046/"]

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
}

extension SelectRestaurantViewController: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return imageArray.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height - 90)
        view.backgroundColor = .white
        
        let restaurantImage = UIImageView()
        restaurantImage.image = UIImage(named: imageArray[index])
        restaurantImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: (UIScreen.main.bounds.height - 90) / 2)
        restaurantImage.contentMode = .scaleAspectFill
        restaurantImage.clipsToBounds = true
        restaurantImage.layer.cornerRadius = 8.0
        view.addSubview(restaurantImage)
        
        let restaurantName = UILabel()
        restaurantName.text = nameArray[index]
        restaurantName.textColor = .black
        restaurantName.frame = CGRect(x: 0, y: restaurantImage.bounds.maxY + 30, width: UIScreen.main.bounds.width - 32, height: 25)
        restaurantName.textAlignment = .center
        restaurantName.font = UIFont(name: "Avenir Next Condensed", size: 30)
        view.addSubview(restaurantName)
        
        let restaunrantDescription = UILabel()
        restaunrantDescription.text = descriptionArray[index]
        restaunrantDescription.textColor = .black
        restaunrantDescription.frame = CGRect(x: 0, y: restaurantName.frame.maxY, width: UIScreen.main.bounds.width - 32, height: 200)
        restaunrantDescription.font = UIFont(name: "Avenir Next Condensed", size: 15)
        restaunrantDescription.numberOfLines = 0
        view.addSubview(restaunrantDescription)
        
        let leftDistance = (UIScreen.main.bounds.width - 32 * 3) / 4
        
        let checkmarkButton = UIButton()
        let image = UIImage(named: "checkmark")
        checkmarkButton.setImage(image, for: .normal)
        checkmarkButton.frame = CGRect(x: leftDistance * 3 + 32 * 2, y: restaunrantDescription.frame.maxY, width: 32, height: 32)
        checkmarkButton.clipsToBounds = true
        checkmarkButton.layer.cornerRadius = 16
        view.addSubview(checkmarkButton)
        
        let starButton = UIButton()
        let starImage = UIImage(named: "star")
        starButton.setImage(starImage, for: .normal)
        starButton.frame = CGRect(x: leftDistance * 2 + 32, y: restaunrantDescription.frame.maxY, width: 32, height: 32)
        starButton.clipsToBounds = true
        starButton.layer.cornerRadius = 16
        view.addSubview(starButton)
        
        let crossmarkButton = UIButton()
        let crossImage = UIImage(named: "none")
        crossmarkButton.setImage(crossImage, for: .normal)
        crossmarkButton.frame = CGRect(x: leftDistance, y: restaunrantDescription.frame.maxY, width: 32, height: 32)
        crossmarkButton.clipsToBounds = true
        crossmarkButton.layer.cornerRadius = 16
        view.addSubview(crossmarkButton)
        
        return view
    }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.up, .left, .right]
    }
    
    //dtagの方向など
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == .right {
            // 「ストックしました」のアラートを出してあげる
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            let alert: UIAlertController = UIAlertController(title: "ストックに成功しました", message: "ストックしたレストランは後から確認できます", preferredStyle:  UIAlertController.Style.alert)

            // ② Actionの設定
            // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
            // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
            })

            // ③ UIAlertControllerにActionを追加
            alert.addAction(defaultAction)

            // ④ Alertを表示
            present(alert, animated: true, completion: nil)
        }
        
        if direction == .up {
            // 地図表示前にアラート表示
            let alert: UIAlertController = UIAlertController(title: "今すぐここに行く", message: "地図を表示しました", preferredStyle:  UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
            
            // スーパーライク時は地図を表示
            //MapViewを生成し、表示する
            let myMapView = MKMapView()
            myMapView.frame = CGRect(x: -16, y: -32, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            restaurantCardView.addSubview(myMapView)
            
            // 以下新宿周辺を指定
            //緯度の指定
            let latitude:CLLocationDegrees = 35.691574

            //経度の指定
            let longtude:CLLocationDegrees = 139.704647

            //地図の広さ：画面の端から端までの緯度の差 (これを大きくするとズームアウト)
            let latDelta:CLLocationDegrees = 0.01
            let lonDelta:CLLocationDegrees = 0.01

            //地図の広さを指定して広さ(span)を割り出す
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)

            //経度と緯度を指定して位置(location) を割り出す
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtude)

            //region:位置と広さを指定して地図を表示する。
            let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
            
            myMapView.setRegion(region, animated: true)
            
            // ピンの設置
            let pin = MKPointAnnotation()
            pin.coordinate = location
            myMapView.addAnnotation(pin)
        }
        
        if direction == .left {
            // 次のカードを表示
            print("NOPE")
        }
    }
    
    @objc private func checkmarkButtonTapped(view: KolodaView) {
        
    }
}

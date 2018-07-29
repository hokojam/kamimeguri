//
//  MapViewController.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/06/25.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

//mapjson

//日付のテンプレート、今日の日付を取得

//device width height
var bounds = UIScreen.main.bounds
var MaxX = bounds.maxX
var MaxY = bounds.maxY
var width = bounds.size.width
var height = bounds.size.height
var myMapView = GMSMapView()

class MapViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate{
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var InfoLabel: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var WritingBtn: UIButton!
    @IBAction func WritingBtnTapped(_ sender: UIButton) {
    }
    var locationManager: CLLocationManager!

    //------------------地図を表示  start----------------------------------
    //最初からあるメソッド
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set map view delegate
        //myMapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100 //丸の範囲(精度)
        locationManager.startUpdatingLocation()
        // 位置情報取得をユーザーに認証してもらう
        locationManager.requestAlwaysAuthorization()
        myMapView.isMyLocationEnabled = true
        
        // viewでmapを追加
        self.view = myMapView
        
        
        //mapstyle customize
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "mapStyle", withExtension: "json") {
                myMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
            // myMapView.mapStyle = try GMSMapStyle(jsonString: kMapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        //------------------地図を表示  end----------------------------------
        
        
        //------------------日付などのラベル   start----------------------------------
        infoView.layer.cornerRadius = 20
        infoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        infoView.layer.shadowColor = UIColor.black.cgColor

        infoView.layer.shadowOpacity = 0.5 // 透明度
        infoView.layer.shadowOffset = CGSize(width: 0, height: 2) // 距離
        infoView.layer.shadowRadius = 4 // ぼかし量
        
        
        //日付を取得
        let MDINfo = DateFormatter()
        MDINfo.setTemplate(.MDDate)
        dateLabel.text = "\(MDINfo.string(from: Date()))"
        
        //曜日を取得
        let weekdayInfo = DateFormatter()
        weekdayInfo.setTemplate(.weekDay)
        weekdayLabel.text = "(\(weekdayInfo.string(from: Date())))"
 
        myMapView.addSubview(WritingBtn)
        myMapView.addSubview(infoView)
        
    }
    
    //Location Manager delegates 地図が出る
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        myMapView.animate(to: camera)//これ何？？
        //Finally stop updating location otherwise it will come again and again in this delegate
        
        
        let position = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!) //need to be unwrapped (read one more time)
        let marker = GMSMarker(position: position)
       
        marker.title = "東京大神宮"//APIで取得
        marker.snippet = "東京都千代田区富士見２丁目４−１"
        //marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "mapMarker_shrine")// GMSMarker.markerImage(with: UIColor.green)
        //locationMarker.opacity = 0.85
        marker.isFlat = true
        marker.map = myMapView
        myMapView.selectedMarker = marker
        
        //location
        self.locationManager.stopUpdatingLocation()//??調べる
    }
    
    
    func buttonTapped(_ sender: UIButton!) {
        print("Yeah! Button is tapped!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Writing" {
            let WritingViewController = segue.destination as! WritingViewController
            let postDateInfo = DateFormatter()
            postDateInfo.setTemplate(.fullDate)
            let postDate: String = "\(postDateInfo.string(from: Date()))"
              WritingViewController.postDate = postDate
//              WritingViewController.TempleName.text = "" APIから取る
//              WritingViewController.TempleAddress.text = APIから取る
            

        }
    }
    
}

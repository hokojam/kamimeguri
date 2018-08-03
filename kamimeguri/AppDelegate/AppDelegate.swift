    //
    //  AppDelegate.swift
    //  kamimeguri
    //
    //  Created by Chen Rui on 2018/06/25.
    //  Copyright © 2018 Chen Rui. All rights reserved.
    //
    
    import UIKit
    import CoreData
    import RealmSwift
    import GoogleMaps;
    
    
    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?
    
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            
            // Realm
            do{
                _ = try Realm() //let realm = try Realm()
            }catch {
                print("Error initilising new realm, \(error)")
            }
            
            let googleMapKey = Bundle.plistString(key: .googleMapKey)
            //Google Mapsの初期設定
            GMSServices.provideAPIKey(googleMapKey)
            
            //navigationBarカスタマイズ化
            let naviBarAppearance = UINavigationBar.appearance()
            naviBarAppearance.barTintColor = UIColor(hex: "0FC4CA")
            naviBarAppearance.tintColor = UIColor.white
            //NSAttibutedStringKey.foregroundColor タイトルの文字色
            naviBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            
            return true
            
        }
        
    }
    
    

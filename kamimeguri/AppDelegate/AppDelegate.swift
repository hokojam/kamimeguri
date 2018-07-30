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
    
//    do{
//    let realm = try Realm()
//    catch
//    {}
//    }
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
    
//    func applicationWillTerminate(_ application: UIApplication) {
//        self.saveContext()
//    }
    
    // MARK: - Core Data stack

//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
    }
    
    
    
//}


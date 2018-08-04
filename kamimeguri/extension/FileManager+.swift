//
//  FileManager+.swift
//  kamimeguri
//
//  Created by hokojam on 2018/08/04.
//  Copyright © 2018年 Chen Rui. All rights reserved.
//

import Foundation
import UIKit

extension FileManager {
    
    // ----- Document -----
    
    // DocumentファイルURLを取得
    var documentURL: URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Documents/
        return urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // DocumentファイルURLに引数のファイル名をプラスしたURLを取得
    func documentURL(fileName: String) -> URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Documents/test.txt
        return documentURL.appendingPathComponent(fileName)
    }
    
    // DocumentファイルPath文字列を取得
    var documentPath: String {
        //=> "/var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Documents"
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    // DocumentファイルPath文字列に引数のファイル名をプラスした文字列を取得
    func documentPath(fileName: String) -> String {
        //=> /var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Documents/test.txt
        return (self.documentPath as NSString).appendingPathComponent(fileName)
    }
    
    // ----- Library -----
    
    // LibraryファイルURLを取得
    var libraryURL: URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/
        return urls(for: .libraryDirectory, in: .userDomainMask)[0]
    }
    
    // LibraryファイルURLに引数のファイル名をプラスしたURLを取得
    func libraryURL(fileName: String) -> URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/test.txt
        return libraryURL.appendingPathComponent(fileName)
    }
    
    // LibraryファイルPath文字列を取得
    var libraryPath: String {
        //=> "/var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library"
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
    }
    
    // LibraryファイルPath文字列に引数のファイル名をプラスした文字列を取得
    func libraryPath(fileName: String) -> String {
        //=> /var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/test.txt
        return (self.libraryPath as NSString).appendingPathComponent(fileName)
    }
    
    // ----- Library/Caches -----
    
    // CachesファイルURLを取得
    var cachesURL: URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Caches/
        return urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    // CachesファイルURLに引数のファイル名をプラスしたURLを取得
    func cachesURL(fileName: String) -> URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Caches/test.txt
        return cachesURL.appendingPathComponent(fileName)
    }
    
    // CachesファイルPath文字列を取得
    var cachesPath: String {
        //=> "/var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Caches"
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
    
    // CachesファイルPath文字列に引数のファイル名をプラスした文字列を取得
    func cachesPath(fileName: String) -> String {
        //=> /var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Caches/test.txt
        return (self.cachesPath as NSString).appendingPathComponent(fileName)
    }
    
    // ----- Library/Application Support -----
    
    // Application SupportファイルURLを取得
    var applicationSupportURL: URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Application%20Support/
        return urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
    }
    
    // Application SupportファイルURLに引数のファイル名をプラスしたURLを取得
    func applicationSupportURL(fileName: String) -> URL {
        //=> file:///var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Application%20Support/test.txt
        return applicationSupportURL.appendingPathComponent(fileName)
    }
    
    // Application SupportファイルPath文字列を取得
    var applicationSupportPath: String {
        //=> "/var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Application Support"
        return NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0]
    }
    
    // Application SupportファイルPath文字列に引数のファイル名をプラスした文字列を取得
    func applicationSupportPath(fileName: String) -> String {
        //=> /var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/Library/Application Support/test.txt
        return (self.applicationSupportPath as NSString).appendingPathComponent(fileName)
    }
    
    // ----- Temporary -----
    
    // TemporaryファイルPath文字列を取得
    var temporaryPath: String {
        //=> /private/var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/tmp/
        return NSTemporaryDirectory()
    }
    
    // TemporaryファイルPath文字列に引数のファイル名をプラスした文字列を取得
    func temporaryPath(fileName: String) -> String {
        //=> /private/var/mobile/Containers/Data/Application/XXXX-XXXX-XXXX-XXXX-XXXX/tmp/test.txt
        return (temporaryPath as NSString).appendingPathComponent(fileName)
    }
    
    // ----- Files List -----
    
    // 指定フォルダのファイル名の一覧を取得
    func fileNames(atPath: String) -> [String] {
        do {
            return try contentsOfDirectory(atPath: atPath)
        } catch {
            return []
        }
    }
    
    // ----- Delete Path -----
    
    // pathのファイルを削除
    func removeFile(atPath: String) -> Bool {
        do {
            try removeItem(atPath: atPath)
            return true
        } catch {
            return false
        }
    }
    
    // ----- Files Exists -----
    
    // atPathで指定したファイルの存在確認
    func fileExistsPath(atPath: String) -> Bool {
        return fileExists(atPath: atPath)
    }
    
    // ----- Create Directory -----
    
    // 指定したディレクトリのPathが無かったら作成する
    func createDirectory(atPath: String) {
        if !fileExists(atPath: atPath) {
            do {
                try createDirectory(atPath: atPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
        }
    }
    
    // 指定したディレクトリのURLが無かったら作成する
    func createDirectory(url: URL) {
        if !fileExists(atPath: url.path) {
            do {
                try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
        }
    }
    
    // ----- Create File -----
    
    /// atPathのにファイルを作成する
    ///
    /// - Parameters:
    ///   - atPath: ファイルPath
    ///   - data: 書き込むData
    /// - Returns: 成功: true, 失敗: false
    func createFile(atPath: String, data: Data? = nil) -> Bool  {
        return createFile(atPath: atPath, contents: data, attributes: nil)
    }
    
    // ----- UIImage Read & Write -----
    
    func writeImage(url: URL, image: UIImage) -> Bool {
        do {
            try UIImagePNGRepresentation(image)?.write(to: url)
            return true
        } catch {
            return false
        }
    }
    
    func getImage(rul: URL) -> UIImage? {
        return UIImage(contentsOfFile: rul.path)
    }
    
    func getImage(atPath: String) -> UIImage? {
        return UIImage(contentsOfFile: atPath)
}
}

//
//  File Manager Extensions.swift
//  Scheduler
//
//  Created by Oscar Victoria Gonzalez  on 1/17/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

extension FileManager {
    // function gets URL path to documents directory
    // FileManager.getDocumentsDirectory
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in:
            FileManager.SearchPathDomainMask.userDomainMask)[0]
    }
    
    // documents/schedules.plist "schedules.plist"
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
}


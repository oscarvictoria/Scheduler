//
//  Persistance Helper.swift
//  Scheduler
//
//  Created by Oscar Victoria Gonzalez  on 1/17/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

enum DataPersistanceError: Error { // conforming to the Error protocol
    case savingError(Error) // associative value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistanceHelper {
    // CRUD - create, read, update, delete
    
    private static var events = [Event]()
    
    private static let filename = "schedules.plist"
    
    // create - save item to documents directory
    
    private static func save() throws {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // append new event to the events array
        
        // events array will be object being converted to data
        // we will use the data object and write (save) it to documents directory
        do {
            // convert (serialize) the events array to Data
            let data = try PropertyListEncoder().encode(events)
            
            // writes, saves, persist the data to the documents directory
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistanceError.savingError(error)
        }
    }
    
    
    static func save(event: Event) throws {
//        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // append new event to the events array
        events.append(event)
        
        try save()
        
        do {
            try save()
        } catch {
            throw DataPersistanceError.savingError(error)
        }
        
        // events array will be object being converted to data
        // we will use the data object and write (save) it to documents directory
    
    }
    
    // read - load (retrieve) items from documents directory
    static func loadEvents() throws -> [Event]  {
        // we need access to the filename url that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if file exist
        // to convert URL to string we use .path on the url
        if FileManager.default.fileExists(atPath: url.path) {
            
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    events = try PropertyListDecoder().decode([Event].self, from: data)
                } catch {
                    throw DataPersistanceError.decodingError(error)
                }
            } else {
               throw DataPersistanceError.noData
            }
           
        } else {
            throw DataPersistanceError.fileDoesNotExist(filename)
        }
         return events
    }
        
        // update -
        
        
        // delete - remove items from documents directory
    static func delete(event index: Int) throws {
        events.remove(at: index)
        
        // save our events array to the documents directory
        do {
           try save()
        } catch {
            throw DataPersistanceError.deletingError(error)
        }
    }

}

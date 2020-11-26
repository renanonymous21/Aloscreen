//
//  UsersOperational.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//

import UIKit
import CoreData

class UsersOperational {
    
    static func insertUser(name: String, username: String, password: String, phone: String, email: String, gender: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let ctx = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: EntityName.Users.rawValue, in: ctx)
        let insert = NSManagedObject(entity: userEntity!, insertInto: ctx)
        let createdAt = timestampLocal()
        
        insert.setValue(name, forKey: "name")
        insert.setValue(username, forKey: "username")
        insert.setValue(password, forKey: "password")
        insert.setValue(phone, forKey: "phone")
        insert.setValue(email, forKey: "email")
        insert.setValue(gender, forKey: "gender")
        insert.setValue(createdAt, forKey: "createdAt")
        insert.setValue(false, forKey: "isLoggedIn")

        do {
            try ctx.save()
        } catch let error {
            print(error)
        }
    }
    
    static func readUser() throws -> [UserLocalDataModel] {
        var users = [UserLocalDataModel]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let ctx = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.Users.rawValue)
        
        do {
            let res = try ctx.fetch(fetchReq) as! [NSManagedObject]
            res.forEach {
                user in
                
                users.append(
                    UserLocalDataModel(
                        name: user.value(forKey: "name") as! String,
                        username: user.value(forKey: "username") as! String,
                        password: user.value(forKey: "password") as! String,
                        phone: user.value(forKey: "phone") as! String,
                        email: user.value(forKey: "email") as! String,
                        gender: user.value(forKey: "gender") as! String,
                        createdAt: user.value(forKey: "createdAt") as! String,
                        isLoggedIn: user.value(forKey: "isLoggedIn") as! Bool
                    )
                )
            }
        } catch let error {
            throw error
        }
       
        
        return users
    }
    
    static func updateUser(username: String,  name: String, email: String, phone: String, gender: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let ctx = appDelegate.persistentContainer.viewContext
        let fetchReq: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: EntityName.Users.rawValue)
        fetchReq.predicate = NSPredicate(format: "username = %@", username)
        
        do {
            let fetch = try ctx.fetch(fetchReq)
            let data = fetch[0] as! NSManagedObject
            data.setValue(name, forKey: "name")
            data.setValue(email, forKey: "email")
            data.setValue(phone, forKey: "phone")
            data.setValue(gender, forKey: "gender")
            
            try ctx.save()
            alert.showMessage(title: "Okay", msg: "Your data has been updated")
        } catch let error {
            print(error)
        }
    }
    
    static func deleteAllData(_ entity:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                appDelegate.persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    static func changeLoginStatus(username: String, isLoggedIn: Bool, isLogout: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let ctx = appDelegate.persistentContainer.viewContext
        let fetchReq: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: EntityName.Users.rawValue)
        fetchReq.predicate = NSPredicate(format: "username = %@", username)
        
        do {
            let fetch = try ctx.fetch(fetchReq)
            let data = fetch[0] as! NSManagedObject
            data.setValue(isLoggedIn, forKey: "isLoggedIn")
            
            try ctx.save()
        } catch let error {
            print(error)
        }
    }
    
    static func timestampLocal() -> String {
        let now = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringDate = df.string(from: now)
        
        return stringDate
    }
}

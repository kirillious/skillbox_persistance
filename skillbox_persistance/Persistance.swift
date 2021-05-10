//
//  Persistance.swift
//  skillbox_persistance
//
//  Created by Kirill on 28.04.2021.
//

import Foundation
import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
}

class Tasks: Object {
    @objc dynamic var tasks = ""
}

class Degrees: Object {
    @objc dynamic var degree = ""
}

class Persistence {
    static let shared = Persistence()
    
    // a task
    private let kUserName = "Persistance.kUserName"
    private let kUserSurname = "Persistance.kUserSurname"
    private let kOnceExec = "Persistance.kOnceExec"
    
    var userName: String? {
        set {UserDefaults.standard.setValue(newValue, forKey: kUserName)}
        get { return UserDefaults.standard.string(forKey: kUserName)}
    }
    
    
    var userSurname: String? {
        set {UserDefaults.standard.setValue(newValue, forKey: kUserSurname)}
        get { return UserDefaults.standard.string(forKey: kUserSurname)}
    }
    
    var onceExec: Bool? {
        set {UserDefaults.standard.setValue(newValue, forKey: kOnceExec)}
        get {return UserDefaults.standard.bool(forKey: kOnceExec)}
    }
    
    
    
    
    //b task
    private let realm = try! Realm()
    func addTask(task1: String) {
        try! realm.write({
            let task = Tasks()
            task.tasks = task1
            realm.add(task)
        })
    }
    
        
        func deleteTask(taskNumber: Int) {
            try! realm.write({
                realm.delete(realm.objects(Tasks.self)[taskNumber])
            })
        }
    
    func updateListDidLoad() -> [String] {
        var list: [String] = []
        for x in realm.objects(Tasks.self) {
            list.append(x.tasks)
        }
        return list
    }
    //c task
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func addTaskCoreData(task1: String) {
        let task = Task(context: self.context)
        task.task = task1
        try! self.context.save()
    }
    
    func removeTaskCoreData(taskNumber: Int) {
       try! self.context.delete(context.fetch(Task.fetchRequest())[taskNumber])
        try! self.context.save()
    }
    
    func fetchingCoreData() -> [String] {
        var data: [Task] = []
        var x: [String] = []
        do {
            data = try context.fetch(Task.fetchRequest())
            for y in data {
                x.append(y.task!)
            }
        } catch {
            print("Something gone wrong")
        }
        return x
    }
    
    
    // d_task
    
    func retriveWeatherList() -> [String]  {
        var pastData: [String] = []
        
        try! realm.write {
            for x in realm.objects(Degrees.self) {
                
                pastData.append(x.degree)
            }
            print(realm.objects(Degrees.self))
        }
        return pastData
    }
    

    
    func updateMemory(list: [String]) {
        try! realm.write {
            
            var i = 0
            while i < 16 {
                realm.objects(Degrees.self)[i].degree = list[i]
                i += 1
            }
        }
    }
    
    func createObjects() {
        if onceExec! == false {
            onceExec! = true
            try! realm.write {
                var i = 0
                while i < 16 {
                    var degree = Degrees()
                    degree.degree = ""
                    realm.add(degree)
                    i += 1
                }
            }
            
        }
        
    }
    
    func realmPrint () {
        print(realm.objects(Degrees.self).count)
    }
}

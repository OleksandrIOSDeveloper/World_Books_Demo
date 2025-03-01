//
//  CoreDataService.swift
//  World News Demo
//
//  Created by Александр Родителев on 02.02.2024.
//


import UIKit
import CoreData

class CoreDataService {
    
    var bookEntities: [BookEntity] = []
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Не удалось загрузить хранилище данных: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveSelectedBook(author: String, discription: String, image: String, title: String) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Books", in: context)!
        let selectedBook = NSManagedObject(entity: entity, insertInto: context)
        selectedBook.setValue(author, forKeyPath: "author")
        selectedBook.setValue(discription, forKeyPath: "discription")
        selectedBook.setValue(image, forKeyPath: "image")
        selectedBook.setValue(title, forKeyPath: "title")
        
        do {
            try context.save()
            updateBookEntities()
        } catch let error as NSError {
            print("Не удалось сохранить выбранную книгу: \(error), \(error.userInfo)")
        }
    }
    
    func loadSelectedBook() -> ([NSManagedObject]) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        
        do {
            let selectedBooks = try context.fetch(fetchRequest)
            return selectedBooks
        } catch let error as NSError {
            print("Не удалось загрузить выбранную книгу: \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteBook(title: String) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let fetchedBooks = try context.fetch(fetchRequest)
            for book in fetchedBooks {
                if let bookObject = book as? NSManagedObject {
                    context.delete(bookObject)
                }
            }
            
            try context.save()
            updateBookEntities()
        } catch {
            print("Не удалось удалить книгу из Core Data: \(error)")
        }
    }
    
    func convertToBookEntities(managedObjects: [NSManagedObject]) {
        for managedObject in managedObjects {
            guard let author = managedObject.value(forKey: "author") as? String,
                  let discription = managedObject.value(forKey: "discription") as? String,
                  let image = managedObject.value(forKey: "image") as? String,
                  let title = managedObject.value(forKey: "title") as? String else {
                continue
            }
            
            let bookEntity = BookEntity(author: author, discription: discription, image: image, title: title)
            bookEntities.append(bookEntity)
        }
    }
    
    func updateBookEntities() {
        bookEntities.removeAll()
        convertToBookEntities(managedObjects: loadSelectedBook())
    }
    
}


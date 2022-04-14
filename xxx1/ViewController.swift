//
//  ViewController.swift
//  xxx1
//
//  Created by Yan Cheng Cheok on 11/04/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func read(_ sender: Any) {
        print("read")
        
        CoreDataStack.INSTANCE.backgroundContext.performAndWait {
            let fetchRequest = Todo.fetchRequest()
            
            do {
                let todos = try fetchRequest.execute()
                
                for todo in todos {
                    print("\(todo.objectID), \(todo.title), \(todo.body)")
                }
            } catch {
                print("\(error)")
            }
        }
    }
    
    @IBAction func write(_ sender: Any) {
        print("write")
        
        let backgroundContext = CoreDataStack.INSTANCE.backgroundContext
        
        backgroundContext.perform {
            do {
                
                let count = try backgroundContext.count(for: Todo.fetchRequest())
                
                let todo = Todo(context: CoreDataStack.INSTANCE.backgroundContext)
                
                todo.title = "title \(count)"
                
                todo.body = "body \(count)"
                
                CoreDataStack.saveContextIfPossible(backgroundContext)
                
                print("success write \(todo.title), \(todo.body)")
            } catch {
                print("\(error)")
            }
        }
    }
    
}


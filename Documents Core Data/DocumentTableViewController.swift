//
//  DocumentTableViewController.swift
//  Documents
//
//  Created by Ante Plecas on 2/6/20.
//  Copyright © 2020 Ante Plecas. All rights reserved.
//

import UIKit
import CoreData

class DocumentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
       @IBOutlet weak var documentsTableView: UITableView!
       let dateFormatter = DateFormatter()
       var documents = [Document]()

       override func viewDidLoad() {
           super.viewDidLoad()
           
           title = "Documents"

           dateFormatter.dateStyle = .medium
           dateFormatter.timeStyle = .medium
       }
       
       override func viewWillAppear(_ animated: Bool) {
           fetchDocuments()
           documentsTableView.reloadData()
       }
       
       func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
               (alertAction) -> Void in
               print("OK selected")
           })
           
           self.present(alert, animated: true, completion: nil)
       }
       
       func fetchDocuments() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
               return
           }
           let managedContext = appDelegate.persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
           fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)] // order results by document name ascending
           
           do {
               documents = try managedContext.fetch(fetchRequest)
           } catch {
               alertNotifyUser(message: "Fetch for documents could not be performed.")
               return
           }
       }
       
       func deleteDocument(at indexPath: IndexPath) {
           let document = documents[indexPath.row]
           
           if let managedObjectContext = document.managedObjectContext {
               managedObjectContext.delete(document)
               
               do {
                   try managedObjectContext.save()
                
                   self.documents.remove(at: indexPath.row)
                
                   documentsTableView.deleteRows(at: [indexPath], with: .automatic)
               } catch {
                   alertNotifyUser(message: "Delete failed.")
                   documentsTableView.reloadData()
               }
           }
       }
       
       func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return documents.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
           
           if let cell = cell as? DocumentCell {
               let document = documents[indexPath.row]
               cell.nameLabel.text = document.name
               cell.sizeLabel.text = String(document.size) + " bytes"
               
               if let modifiedDate = document.modifiedDate {
                   cell.modLabel.text = dateFormatter.string(from: modifiedDate)
               } else {
                   cell.modLabel.text = "unknown"
               }
           }
           
           return cell
       }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? DocumentViewController,
              let segueIdentifier = segue.identifier, segueIdentifier == "existingDocument",
              let row = documentsTableView.indexPathForSelectedRow?.row {
                   destination.document = documents[row]
           }
       }
       
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               deleteDocument(at: indexPath)
           }
       }
       

}


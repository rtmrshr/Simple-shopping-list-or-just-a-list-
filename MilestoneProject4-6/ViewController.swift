//
//  ViewController.swift
//  MilestoneProject4-6
//
//  Created by  ratmir on 17.01.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareTapped))
        toolbarItems = [shareButton]
        navigationController?.isToolbarHidden = false 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
   
    @objc func refresh() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func add() {
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addItem = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.shoppingList.insert(answer, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        ac.addAction(addItem)
        present(ac, animated: true)
      
    }
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        //UIActivityViewController, which is the iOS method of sharing content with other apps and services.
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        //Finally, we tell iOS where the activity view controller should be anchored – where it should appear from.
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}


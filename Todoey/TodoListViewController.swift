//
//  ViewController.swift
//  Todoey
//
//  Created by DX推進 on 2020/07/29.
//  Copyright © 2020 DX推進. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //過去に追加した要素が保管されている場所にアクセスし、データを引っ張ってくる
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    
    //MARK - Tableview Datasource Methoda ~~~~~~~~~~~~~~~~~~~~
    
    //初めから起動
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //要素数分リストを表示する
        return itemArray.count
    }
    
    //初めから起動
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //表示するテキストを決定する
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods ~~~~~~~~~~~~~~~~~~~~
    
    //選択すると起動する
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //選択するとチェックマークが切り替わる
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items ~~~~~~~~~~~~~~~~~~~~
    
    //押すと反応する
    @IBAction func addButtonPrePressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
                
        //ボタンを押した後のアクション
        let action = UIAlertAction(title: "Add Item", style: .default){
            //what will happen once the user clicks the Add Item button on our UIAlert
            (action) in
            self.itemArray.append(textField.text!)
            
            //データ保管先の内容をアップデート
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        //テキスト記入欄作成R
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            print(alertTextField.text)
        }
        
        alert.addAction(action)
        
        //アラート表示
        present(alert, animated: true, completion: nil)
    }
    
    
    


}


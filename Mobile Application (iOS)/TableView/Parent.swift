//
//  Parent.swift
//  TableView
//
//  Created by Richard Richard on 9/1/17.
//  Copyright © 2017 Richard Richard. All rights reserved.
//

import UIKit

class Parent: UIViewController {
    
    var userToUpdate = [String:Any]()
    var arrayOfUsers = [[String:Any]]()
    var dataTable: UITableView?
    
    // Get the screen size
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    let viewHeight: CGFloat = UIScreen.main.bounds.size.height
    let viewWidth: CGFloat = UIScreen.main.bounds.size.width
    
    enum labelText: String {
        case nim = "NIM"
        case name = "Name"
        case course = "Course"
        case score = "Score"
    }
    enum urlList: String {
        case userList = "https://fierce-falls-71149.herokuapp.com/users/userlist"
        case addUser = "https://fierce-falls-71149.herokuapp.com/users/adduser"
        case deleteUser = "https://fierce-falls-71149.herokuapp.com/users/deleteuser/"
        case updateUser = "https://fierce-falls-71149.herokuapp.com/users/updateuser/"
    }
    
    // From TableViewController to AddViewController
    func moveToAddView() {
        let addView = storyboard?.instantiateViewController(withIdentifier: "addDataView") as! AddViewController
        self.navigationController?.pushViewController(addView, animated: true)
    }
    
    // Get user data from internet
    func getuserList(){
        var request = URLRequest(url: URL(string: urlList.userList.rawValue)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with:request) { (data, response, error) in
            if error != nil {
                print(error ?? "")
            } else {
                do {
                    let response = try JSONSerialization.jsonObject(with: data!, options: [])
                    guard let jsonResult = response as? [String: Any] else {
                        print("invalid format")
                        return
                    }
                    let studentsData = jsonResult["students"] as? [[String:Any]]
                    // Save data in local array of dictionary
                    self.arrayOfUsers = studentsData ?? []
                    DispatchQueue.main.async {
                        self.dataTable?.reloadData()
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
    }
    
    func addUser(nim: String, name: String, course: String, score: String) {
        var addUrl = URLRequest(url: URL(string: urlList.addUser.rawValue)!)
        addUrl.httpMethod = "POST"
        let postString = "nim=\(nim)&name=\(name)&course=\(course)&score=\(score)"
        addUrl.httpBody = postString.data(using: .utf8)
        urlTaskSession(urlTask: addUrl)
    }
    
    func deleteUser(idToDelete: String) {
        let idToDelete:String = idToDelete 
        var deleteUrl = URLRequest(url: URL(string: "\(urlList.deleteUser.rawValue)\(idToDelete)")!)
        deleteUrl.httpMethod = "DELETE"
        urlTaskSession(urlTask: deleteUrl)
    }
    
    func updateUser(userToUpdate: [String:Any], nim: String, name: String, course: String, score: String) {
        let idToUpdate:String = userToUpdate["_id"] as! String
        var updateUrl = URLRequest(url: URL(string: "\(urlList.updateUser.rawValue)\(idToUpdate)")!)
        updateUrl.httpMethod = "PUT"
        let postString = "nim=\(nim)&name=\(name)&course=\(course)&score=\(score)"
        updateUrl.httpBody = postString.data(using: .utf8)
        updateUrl.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlTaskSession(urlTask: updateUrl)
    }
    
    func urlTaskSession(urlTask: URLRequest) {
        let task = URLSession.shared.dataTask(with: urlTask) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        getuserList()
    }
}

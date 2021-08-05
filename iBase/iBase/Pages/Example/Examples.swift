//
//  Examples.swift
//  iBase
//
//  Created by Numan Ayhan on 22.07.2021.
//

import UIKit

class Examples: UIViewController {

    struct Const {
      static let usersEP = URL(string: "https://jsonplaceholder.typicode.com/users")
    }
    private let table:UITableView = {
       let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    var users = [Users]()
    var search : FloatLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        
        
    }
    func setTableView(){
         
//        alert("Sales Room" ,"Hi")
        view.backgroundColor = .white
//        view.addSubview(table)
//        table.frame = view.bounds
//        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        
        search = FloatLabelTextField()
        search.placeholder = "Müşteri*"
        search.font = UIFont.init(name: "OpenSans-Bold", size: 21)
        search.titleActiveTextColour = UIColor.hex("#8E929B")
        search.attributedPlaceholder = NSAttributedString(string: "Müşteri*", attributes: [NSAttributedString.Key.foregroundColor : UIColor.hex("#565C69")])
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: search.frame.height - 2, width:  search.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.hex("#D3D3E0").cgColor
        
        search.layer.addSublayer(bottomLine)
        view.addSubview(search)
        search.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor , paddingTop: 50 , paddingLeft: 15, paddingBottom: 0, paddingRight:15, width: view.frame.width, height: 50)
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func fetchUser(){
        
        URLSession.shared.request(url: Const.usersEP, expecting: [Users].self) { [weak self ] result  in
            switch result {
            case .success(let users):
            DispatchQueue.main.async {
                self?.users = users
                self?.table.reloadData()
            } 
            case .failure(let error ):
                if !error.localizedDescription.isEmpty {
                    print(error.localizedDescription)
                    self!.alertAction("Sales Room" ,error.localizedDescription)
                }
            }
        }
    }

}
extension Examples : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for : indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        
         return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}

struct Users:Codable {
    let name:String
    let id:Int
    let email:String
}

extension URLSession {
    enum CustomError: Error {
        case incalidUrl
        case invalidData
    }
    func request<T: Codable>(
        url:URL? ,
        expecting:T.Type ,
        completion: @escaping (Result<T,Error>) ->Void
    ){
        guard let url =  url else {
            completion(.failure(CustomError.incalidUrl))
            return
        }
        let task = dataTask(with: url){ data , _ , error in
            guard let data = data else{
                if let error = error {
                   
                    completion(.failure(error))
                }else{
                    completion(.failure(CustomError.invalidData))
                }
                
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
}

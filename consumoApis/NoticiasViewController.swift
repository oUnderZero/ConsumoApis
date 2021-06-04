//
//  NoticiasViewController.swift
//  consumoApis
//
//  Created by Mac14 on 26/05/21.
//

import UIKit

struct Noticia: Codable{
    var title: String
    var description: String?
}

struct Noticias: Codable {
    var articles: [Noticia]
}

class NoticiasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var noticias = [Noticia]()
  
    
    
    @IBOutlet weak var tablaN: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://newsapi.org/v2/top-headlines?country=mx&apiKey=3247be9794b8415a95e6d5d5c8967333"
        // Do any additional setup after loading the view.
        if let url = URL(string: urlString){
            if let datos = try? Data(contentsOf: url){
                parsear(json: datos)
            }
        }

        // Do any additional setup after loading the view.
    }
    
func parsear(json: Data){
    let decoder = JSONDecoder()
    
    if let jsonPeticiones = try? decoder.decode(Noticias.self, from: json){
        noticias = jsonPeticiones.articles
        tablaN.reloadData()
    }
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return noticias.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let celda = tablaN.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    celda.textLabel?.text = noticias[indexPath.row].title
    
    celda.detailTextLabel?.text = noticias[indexPath.row].description
    return celda
    
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

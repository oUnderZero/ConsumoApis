

import UIKit
struct Pais: Codable{
    var country: String?
    var cases: Int?
  //  var description: String?
}


class CovidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var misPaises = [Pais]()
    

    @IBOutlet weak var urlimg: UIImageView!
    @IBOutlet weak var tablaC: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
       
        if let url = URL(string: urlString){
            if let datos = try? Data(contentsOf: url){
                parsear(json: datos)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func parsear(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPeticiones = try? decoder.decode([Pais].self, from: json){
            self.misPaises = jsonPeticiones
            tablaC.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misPaises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       

        let celda = tablaC.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        celda.textLabel?.text = misPaises[indexPath.row].country
        celda.detailTextLabel?.text = "Casos: \(misPaises[indexPath.row].cases!)"
        return celda
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

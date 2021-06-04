

import UIKit

struct Peticion: Codable{
    var title: String
    var body: String
}

struct Peticiones: Codable {
    var results: [Peticion]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var peticiones = [Peticion]()
    
    @IBOutlet weak var tablaj: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        // Do any additional setup after loading the view.
        if let url = URL(string: urlString){
            if let datos = try? Data(contentsOf: url){
                parsear(json: datos)
            }
        }
    }
    func parsear(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPeticiones = try? decoder.decode(Peticiones.self, from: json){
            peticiones = jsonPeticiones.results
            tablaj.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peticiones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaj.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = peticiones[indexPath.row].title
        celda.detailTextLabel?.text = peticiones[indexPath.row].body
        return celda
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}


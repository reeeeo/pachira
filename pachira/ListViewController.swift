import UIKit

class ListViewController: UIViewController {
  @IBOutlet weak var myTableView: UITableView!
  
  fileprivate var ideas: [Idea] = []
  fileprivate var selectedIdea: Idea?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.myTableView.dataSource = self
    self.myTableView.delegate = self
    self.ideas = CDIdea.coreData.all()
  }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ideas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    let idea = self.ideas[indexPath.row]
    cell.textLabel?.text = idea.name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedIdea = ideas[indexPath.row]
    performSegue(withIdentifier: "toDetailSeg", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destination = segue.destination
    if destination is DetailViewController {
      let dvc: DetailViewController = destination as! DetailViewController
      dvc.idea = self.selectedIdea
    } else {
      super.prepare(for: segue, sender: sender)
    }
  }
}

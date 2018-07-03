import UIKit

class ListViewController: UIViewController {
  private lazy var myTableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  fileprivate var ideas: [Idea] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "l!st"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.ideas = CDIdea.coreData.all()
    self.myTableView.reloadData()
    self.view = self.myTableView
  }
}

extension ListViewController: UITableViewDelegate {}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.ideas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    let idea = self.ideas[indexPath.row]
    cell.textLabel?.text = idea.name
    
    cell.contentView.addSubview(getCellImageView(by: idea.pic1, height: cell.contentView.bounds.height, num: 1))
    cell.contentView.addSubview(getCellImageView(by: idea.pic2, height: cell.contentView.bounds.height, num: 2))
    return cell
  }
  
  private func getCellImageView(by id: Int16, height: CGFloat, num: Int) -> UIImageView {
    let iHeight: CGFloat = height
    let iWidth: CGFloat = height
    let posX: CGFloat = num == 1 ? self.view.bounds.size.width - iWidth * 2 - 10 : self.view.bounds.size.width - iWidth
    let posY: CGFloat = 0.0
    let imgV = UIImageView(frame: CGRect(x: posX, y: posY, width: iWidth, height: iHeight))
    imgV.image = PImageManager.findPImage(by: id).getUIImage()
    return imgV
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let next = DetailViewController()
    next.idea = ideas[indexPath.row]
    self.navigationController?.pushViewController(next, animated: true)
  }
}

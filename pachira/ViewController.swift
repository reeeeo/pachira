import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "pach!ra"
    self.addThinkButton()
    self.addListButton()
    self.addThinkingAppleImage()
    self.addThinkImage()
  }
}

extension ViewController {
  private func addThinkButton() {
    let thinkButton = UIButton(type: .system)
    thinkButton.setTitle("th!nk", for: .normal)
    let bWidth: CGFloat = 200
    let bHeight: CGFloat = 50
    let posX: CGFloat = self.view.bounds.width / 4 - bWidth / 2
    let posY: CGFloat = self.view.bounds.height / 4 - bHeight / 2
    thinkButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
    thinkButton.addTarget(self, action: #selector(self.goThinkPage(_:)), for: .touchUpInside)
    thinkButton.titleLabel?.font = UIFont(name: (thinkButton.titleLabel?.font.fontName)!, size: 30)
    self.view.addSubview(thinkButton)
  }
  
  @objc private func goThinkPage(_ sender: UIButton) {
    let next = ThinkViewController()
    self.navigationController?.pushViewController(next, animated: true)
  }
  
  private func addListButton() {
    let listButton = UIButton(type: .system)
    listButton.setTitle("l!st", for: .normal)
    let bWidth: CGFloat = 200
    let bHeight: CGFloat = 50
    let posX: CGFloat = self.view.bounds.width / 4 * 3 - bWidth / 2
    let posY: CGFloat = self.view.bounds.height / 4 - bHeight / 2
    listButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
    listButton.addTarget(self, action: #selector(self.goListPage(_:)), for: .touchUpInside)
    listButton.titleLabel?.font = UIFont(name: (listButton.titleLabel?.font.fontName)!, size: 30)
    self.view.addSubview(listButton)
  }
  
  @objc private func goListPage(_ sender: UIButton) {
    let next = ListViewController()
    self.navigationController?.pushViewController(next, animated: true)
  }
  
  private func addThinkingAppleImage() {
    let iWidth: CGFloat = self.view.bounds.width / 3 + 50
    let iHeight: CGFloat = iWidth * 2 - 50
    let posX: CGFloat = self.view.bounds.width - iWidth
    let posY: CGFloat = self.view.bounds.height - iHeight
    let thinkImage = UIImageView(frame: CGRect(x: posX, y: posY, width: iWidth, height: iHeight))
    thinkImage.image = UIImage(named: "thinkingapple-min.png")
    self.view.addSubview(thinkImage)
  }
  
  private func addThinkImage() {
    let iWidth: CGFloat = self.view.bounds.width + 100
    let iHeight: CGFloat = 200
    let posX: CGFloat = (self.view.bounds.width - iWidth) / 2
    let posY: CGFloat = (self.view.bounds.height - iHeight) / 2
    let thinkImage = UIImageView(frame: CGRect(x: posX, y: posY, width: iWidth, height: iHeight))
    thinkImage.image = UIImage(named: "think-min.png")
    self.view.addSubview(thinkImage)
  }
}

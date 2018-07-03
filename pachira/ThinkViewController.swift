import UIKit

class ThinkViewController: UIViewController {
  private var myPic1: UIImageView!
  private var myPic2: UIImageView!
  private var myIdeaName: UITextField!
  private var myIdeaMemo: UITextView!
  private var myToolbar: UIToolbar!
  
  private var pImages: [PImage] = []
  private var pic1:PImage!
  private var pic2:PImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "th!nk"
    self.view.backgroundColor = .white
    self.pImages = PImageManager.fetchPImages()
    self.addPic1Image()
    self.addPic2Image()
    self.addIdeaNameTextField()
    self.addIdeaMemoTextView()
    self.addToolBar()
    self.addToolbarButton()
    self.addRefreshButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.shuffleImages()
  }
  
  private func addPic1Image() {
    let iWidth: CGFloat = self.view.bounds.width / 3
    let iHeight: CGFloat = iWidth
    let posX: CGFloat = self.view.bounds.width / 4 - iWidth / 2
    let posY: CGFloat = self.view.bounds.height / 4 - iHeight / 2
    self.myPic1 = UIImageView(frame: CGRect(x: posX, y: posY, width: iWidth, height: iHeight))
    self.view.addSubview(self.myPic1)
  }
  
  private func addPic2Image() {
    let iWidth: CGFloat = self.view.bounds.width / 3
    let iHeight: CGFloat = iWidth
    let posX: CGFloat = (self.view.bounds.width / 4) * 3 - iWidth / 2
    let posY: CGFloat = self.view.bounds.height / 4 - iHeight / 2
    self.myPic2 = UIImageView(frame: CGRect(x: posX, y: posY, width: iWidth, height: iHeight))
    self.view.addSubview(self.myPic2)
  }
  
  private func addIdeaNameTextField() {
    let tWidth: CGFloat = (self.view.bounds.width / 3) * 2
    let tHeight: CGFloat = 50
    let posX: CGFloat = self.view.bounds.width / 2 - tWidth / 2
    let posY: CGFloat = self.view.bounds.height / 2 - tHeight /  2 - 35
    self.myIdeaName = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
    self.myIdeaName.layer.borderColor = UIColor.darkGray.cgColor
    self.myIdeaName.borderStyle = .roundedRect
    self.myIdeaName.clearButtonMode = .whileEditing
    self.myIdeaName.placeholder = " enter idea name"
    self.view.addSubview(self.myIdeaName)
  }
  
  private func addIdeaMemoTextView() {
    let tWidth: CGFloat = (self.view.bounds.width / 3) * 2
    let tHeight: CGFloat = 200
    let posX: CGFloat = self.view.bounds.width / 2 - tWidth / 2
    let posY: CGFloat = self.view.bounds.height / 2 + tHeight /  2 - 90
    self.myIdeaMemo = UITextView(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
    self.myIdeaMemo.backgroundColor = UIColor.lightGray
    self.view.addSubview(self.myIdeaMemo)
  }
  
  private func addToolBar() {
    myToolbar = UIToolbar(frame: CGRect(x: 0, y: self.view.bounds.size.height - 45, width: self.view.bounds.size.width, height: 40.0))
    myToolbar.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 20.0)
    self.view.addSubview(self.myToolbar)
  }
  
  private func addToolbarButton() {
    let myRegisterUIBarButton = UIBarButtonItem(
      barButtonSystemItem: .compose,
      target: self,
      action: #selector(self.registerIdea(_:)))
    self.myToolbar.items = [self.createFlexibleSpace(), myRegisterUIBarButton]
  }
  
  private func addRefreshButton() {
    let myRefreshUIBarButton = UIBarButtonItem(
      barButtonSystemItem: .refresh,
      target: self,
      action: #selector(self.reloadImages(_:)))
    self.navigationItem.rightBarButtonItem = myRefreshUIBarButton
  }
  
  private func createFlexibleSpace() -> UIBarButtonItem {
    return UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil)
  }
  
  @objc private func reloadImages(_ sender: UIBarButtonItem) {
    self.shuffleImages()
  }
  
  private func shuffleImages() {
    self.myIdeaName.text = ""
    self.myIdeaMemo.text = ""
    let count = UInt32.init(self.pImages.count)
    var ran:Int = 0
    ran = Int(arc4random_uniform(count))
    self.pic1 = self.pImages[ran]
    ran = Int(arc4random_uniform(count))
    self.pic2 = self.pImages[ran]
    myPic1.image = self.pic1!.getUIImage()
    myPic2.image = self.pic2!.getUIImage()
  }
  
  @objc private func registerIdea(_ sender: UIBarButtonItem) {
    var newIdea: [String:Any] = [:]
    newIdea["name"] = myIdeaName.text
    newIdea["memo"] = myIdeaMemo.text
    newIdea["pic1"] = Int16(self.pic1!.id)
    newIdea["pic2"] = Int16(self.pic2!.id)
    if validateIdea(newIdea) {
      self.showNGAlert()
    } else {
      CDIdea.coreData.add(newIdea)
      self.showOKAlert()
    }
  }
  
  private func validateIdea(_ newIdea: [String: Any]) -> Bool {
    return newIdea["name"] as! String == ""
  }
  
  private func showOKAlert() {
    let alertController = UIAlertController(
      title: "登録しました",
      message: "",
      preferredStyle: .alert
    )
    alertController.view.layer.cornerRadius = 25
    alertController.addAction(
      UIAlertAction(
        title: "OK",
        style: .default,
        handler: {_ in
          self.shuffleImages()
      }))
    present(alertController, animated: true, completion: nil)
  }
  
  private func showNGAlert() {
    let alertController = UIAlertController(
      title: "タイトルを入力してください",
      message: "",
      preferredStyle: .alert
    )
    alertController.view.layer.cornerRadius = 25
    alertController.addAction(
      UIAlertAction(
        title: "OK",
        style: .cancel,
        handler: nil))
    present(alertController, animated: true, completion: nil)
  }
}

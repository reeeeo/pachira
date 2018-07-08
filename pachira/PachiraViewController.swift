import UIKit

class PachiraViewController: UIViewController {
  internal var myPic1: UIImageView!
  internal var myPic2: UIImageView!
  internal var myIdeaName: UITextField!
  internal var myIdeaMemo: UITextView!
  internal var myToolbar: UIToolbar!
  
  private var screenWidth: CGFloat!
  private var screenHeight: CGFloat!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let screenSize = UIScreen.main.bounds
    self.screenWidth = screenSize.width
    self.screenHeight = screenSize.height
    self.view.backgroundColor = .white
    self.addPic1Image()
    self.addPic2Image()
    self.addIdeaNameTextField()
    self.addIdeaMemoTextView()
    self.addToolBar()
  }
  
  private func addIdeaNameTextField() {
    let tWidth: CGFloat = (self.view.bounds.width / 3) * 2
    let tHeight: CGFloat = 50
    let posX: CGFloat = self.view.bounds.width / 2 - tWidth / 2
    let posY: CGFloat = self.view.bounds.height / 2 - tHeight /  2 - 50
    self.myIdeaName = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
    self.myIdeaName.layer.borderColor = UIColor.darkGray.cgColor
    self.myIdeaName.borderStyle = .roundedRect
    self.myIdeaName.clearButtonMode = .whileEditing
    self.myIdeaName.placeholder = " enter idea name"
    self.view.addSubview(self.myIdeaName)
  }
  
  private func addIdeaMemoTextView() {
    let tWidth: CGFloat = (self.view.bounds.width / 3) * 2
    let tHeight: CGFloat = self.view.bounds.height / 3
    let posX: CGFloat = self.view.bounds.width / 2 - tWidth / 2
    let posY: CGFloat = self.view.bounds.height / 2 + tHeight /  2 - 110
    self.myIdeaMemo = UITextView(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
    self.myIdeaMemo.backgroundColor =  UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    self.view.addSubview(self.myIdeaMemo)
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
  
  private func addToolBar() {
    myToolbar = UIToolbar(frame: CGRect(x: 0, y: self.view.bounds.size.height - 65, width: self.view.bounds.size.width, height: 40.0))
    myToolbar.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 20.0)
    self.view.addSubview(self.myToolbar)
  }
  
  internal func createFlexibleSpace() -> UIBarButtonItem {
    return UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil)
  }
  
  internal func validateIdea(_ newIdea: [String: Any]) -> Bool {
    return newIdea["name"] as! String == ""
  }
  
  internal func showNGAlert() {
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

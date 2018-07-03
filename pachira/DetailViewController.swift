import UIKit

class DetailViewController: UIViewController {
  private var myPic1: UIImageView!
  private var myPic2: UIImageView!
  private var myIdeaName: UITextField!
  private var myIdeaMemo: UITextView!
  private var myToolbar: UIToolbar!
  
  var idea: Idea!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "deta!l"
    self.view.backgroundColor = .white
    self.addPic1Image()
    self.addPic2Image()
    self.addIdeaNameTextField()
    self.addIdeaMemoTextView()
    self.showDetail()
    self.addToolBar()
    self.addToolbarButton()
    self.addTrashButton()
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
    let myShareUIBarButton = UIBarButtonItem(
      barButtonSystemItem: .action,
      target: self,
      action: #selector(self.shareIdea(_:)))
    let myUpdateUIBarButton = UIBarButtonItem(
      barButtonSystemItem: .compose,
      target: self,
      action: #selector(self.updateIdea(_:)))
    self.myToolbar.items = [myShareUIBarButton, self.createFlexibleSpace(), myUpdateUIBarButton]
  }
  
  private func addTrashButton() {
    let myTrashUIBarButton = UIBarButtonItem(
      barButtonSystemItem: .trash,
      target: self,
      action: #selector(self.deleteIdea(_:)))
    self.navigationItem.rightBarButtonItem = myTrashUIBarButton
  }
  
  private func createFlexibleSpace() -> UIBarButtonItem {
    return UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil)
  }
  
  private func showDetail() {
    self.myPic1.image = PImageManager.findPImage(by: idea.pic1).getUIImage()
    self.myPic2.image = PImageManager.findPImage(by: idea.pic2).getUIImage()
    self.myIdeaName.text = idea.name
    self.myIdeaMemo.text = idea.memo
  }
  
  @IBAction func deleteIdea(_ sender: UIBarButtonItem) {
    self.confirmAlert()
  }
  
  private func confirmAlert() {
    let alertController = UIAlertController(
      title: "確認",
      message: "削除します。よろしいですか？",
      preferredStyle: .alert
    )
    alertController.view.layer.cornerRadius = 25
    alertController.addAction(
      UIAlertAction(
        title: "OK",
        style: .default,
        handler: {_ in
          CDIdea.coreData.delete(self.idea)
          self.navigationController?.popViewController(animated: true)
      }))
    alertController.addAction(
      UIAlertAction(
        title: "Cancel",
        style: .destructive,
        handler: nil))
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func updateIdea(_ sender: UIBarButtonItem) {
    self.idea.name = myIdeaName.text
    self.idea.memo = myIdeaMemo.text
    CDIdea.coreData.update(self.idea)
    self.showAlert()
  }
  
  private func showAlert() {
    let alertController = UIAlertController(
      title: "更新しました",
      message: "",
      preferredStyle: .alert
    )
    alertController.view.layer.cornerRadius = 25
    alertController.addAction(
      UIAlertAction(
        title: "OK",
        style: .default,
        handler: nil))
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func shareIdea(_ sender: UIBarButtonItem) {
    let textItem = "新しいアイデア「\(myIdeaName.text!)」を考えました！"
    let controller = UIActivityViewController(
      activityItems: [textItem],
      applicationActivities: nil)
    controller.popoverPresentationController?.sourceView = self.view
    present(controller, animated: true, completion: nil)
  }
}

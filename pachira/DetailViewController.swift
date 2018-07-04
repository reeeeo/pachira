import UIKit

class DetailViewController: PachiraViewController {
  var idea: Idea!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = idea.name!
    self.view.backgroundColor = .white
    self.showDetail()
    self.addToolbarButton()
    self.addTrashButton()
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

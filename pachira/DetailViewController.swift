import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var myPic1: UIImageView!
  @IBOutlet weak var myPic2: UIImageView!
  @IBOutlet weak var myIdeaName: UITextField!
  @IBOutlet weak var myIdeaMemo: UITextView!
  
  var idea: Idea!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.showDetail()
  }
  
  private func showDetail() {
    self.myPic1.image = UIImage.init(named: PImageManager.findPImage(by: idea.pic1).path)
    self.myPic2.image = UIImage.init(named: PImageManager.findPImage(by: idea.pic2).path)
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
          self.performSegue(withIdentifier: "toListSegWithDel", sender: nil)
      }))
    alertController.addAction(
      UIAlertAction(
        title: "Cancel",
        style: .destructive,
        handler: nil))
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func updateIdea(_ sender: UIButton) {
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
}

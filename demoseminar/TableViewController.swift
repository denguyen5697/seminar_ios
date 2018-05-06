
import UIKit

class TableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IAPService.shared.getProducts()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("Consumable")
        case 1:
            print("Non-Consumable")
        case 3:
            print("Non-Renewing Subscription")
        default:
            print("Restored")
        }
    }
    func finishTransaction(trans:SKPaymentTransaction)
    {
        print("finish trans")
        SKPaymentQueue.defaultQueue().finishTransaction(trans)
    }
    func paymentQueue(queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction])
    {
        print("remove trans");
    }

    
    
}

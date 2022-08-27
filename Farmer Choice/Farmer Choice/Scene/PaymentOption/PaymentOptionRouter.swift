

import UIKit

@objc protocol PaymentOptionRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PaymentOptionDataPassing
{
  var dataStore: PaymentOptionDataStore? { get }
}

class PaymentOptionRouter: NSObject, PaymentOptionRoutingLogic, PaymentOptionDataPassing
{
  weak var viewController: PaymentOptionViewController?
  var dataStore: PaymentOptionDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: PaymentOptionViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: PaymentOptionDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

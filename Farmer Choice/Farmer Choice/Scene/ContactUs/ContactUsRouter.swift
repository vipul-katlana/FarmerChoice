

import UIKit

@objc protocol ContactUsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ContactUsDataPassing
{
  var dataStore: ContactUsDataStore? { get }
}

class ContactUsRouter: NSObject, ContactUsRoutingLogic, ContactUsDataPassing
{
  weak var viewController: ContactUsViewController?
  var dataStore: ContactUsDataStore?
  
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
  
  //func navigateToSomewhere(source: ContactUsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ContactUsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

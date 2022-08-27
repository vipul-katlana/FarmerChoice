

import UIKit

@objc protocol UpdateProfileRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol UpdateProfileDataPassing
{
  var dataStore: UpdateProfileDataStore? { get }
}

class UpdateProfileRouter: NSObject, UpdateProfileRoutingLogic, UpdateProfileDataPassing
{
  weak var viewController: UpdateProfileViewController?
  var dataStore: UpdateProfileDataStore?
  
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
  
  //func navigateToSomewhere(source: UpdateProfileViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: UpdateProfileDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}

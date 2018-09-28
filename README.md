# DeckOfCardsTest
Minimum Requirements
- Load images async
- Architect the application in MVVM
- Show an example of KVO implementation

To address the following above:
1. Images were loaded using URLSession and GCD, caching images already downloaded. 
2. MVVM was used to represent static Model logic with View Models and bind the Views (individual TableViewCells) with data.
  Some improvements I could have made include placing the Service layer into the viewModel so the controller is completely free from non-UI responsibilities.
3. A trivial KVO example was used by adding a tap count in each cardViewModel, which binds to the individual cells. The observer watches for changes
  in the tap count, and notifies the delegate to update the view.
  

Architecture - MVVM

SwiftUI works very well in MVVM design patterns. 

One of the patterns that I think works well in this is the ViewModel: 

SwiftUI have property wrappers like @State, @Binding and @ObservedObject that make a view dependant on the state of a property, whenever data in this property changes the view that uses it automatically updates.

And on MVVM's ViewModel, it provides a binding to the properties of its model data, and a SwiftUI view using a property w/ wrappers automatically updates when that data changes.


# ReadMe
# A1 - A Checklist App

A1 is a simple checklist app allows users to create and manage their daily routines. Users can add, edit, delete, and reorder items in the checklist.

## ChecklistItem.swift

`ChecklistItem` is a struct that defines the attributes of an item in the checklist. It conforms to the `Identifiable`, `Equatable`, and `Codable` protocols to allow tracking of unique IDs, comparison of instances, and encoding/decoding to/from JSON format.

- `id`: a UUID to uniquely identify each checklist item
- `name`: a string representing the name of the item
- `isChecked`: a boolean flag indicating whether the item is checked or not
- `detail`: a string containing additional details about the item

## ChecklistViewModel.swift

`ChecklistViewModel` is a class that defined as the view model for the checklist app. It contains an array of `ChecklistItem` objects and provides methods for managing the items. This class is an `ObservableObject` to allow SwiftUI views to listen for changes in the data.

- `items`: an array of `ChecklistItem` objects
- `isLoading`: a boolean flag to indicate whether the view is in a loading state

### Methods:

- `addItems()`: adds a new item to the checklist
- `deleteItems(at:)`: deletes items in the checklist at the specified index set
- `editItems(item:name:)`: edits the name of an item in the checklist
- `editDetails(item:detail:)`: edits the details of an item in the checklist
- `resetCheck()`: resets the checkmarks of all items to false
- `moveItems(from:to:)`: reorders items in the checklist
- `saveItems()`: saves the items in the checklist to a JSON file
- `loadItems()`: loads items from the JSON file or initializes with default items if the file is not found or empty
- `getFile()`: returns the URL of the JSON file used for saving/loading items

## ContentView.swift

`ContentView` is the main view of the app, displaying the checklist items in a list. This view uses a `ChecklistViewModel` instance to handle the logic and manage the data.

- `viewModel`: an instance of `ChecklistViewModel`
- `isEditMode`: a boolean state to indicate whether the view is in edit mode or not
- `checklistTitle`: a string representing the title of the checklist
- `editTitle`: a string to store the edited title of the checklist
- `isLoading`: a boolean state to indicate whether the view is in a loading state or not

The `NavigationView` contains a `List` that displays the items in the `viewModel.items` array, allowing users to edit, delete, and reorder items. The `onAppear` modifier is used to load items from the JSON file when the view appears.

## ItemDetailView.swift

`ItemDetailView` is a view that displays the details of an individual checklist item. It allows users to edit the name and details of the item.

- `viewModel`: an instance of `ChecklistViewModel`
- `item`: a `ChecklistItem` object representing the item to be displayed

### State properties:

- `isEditMode`: a boolean state to indicate whether the view is in edit mode or not
- `itemName`: a string to store the edited name of the item
- `itemDetails`: a string to store the edited details of the item

The view displays the name and details of the item, and allows users to edit these values when in edit mode. When the view exits edit mode, the edited values are saved

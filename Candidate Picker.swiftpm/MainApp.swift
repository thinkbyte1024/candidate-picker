// CoreData libraries
//import CoreData

// CoreStore libraries
import CoreStore

import SwiftUI
import SwiftUIX

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            MainListView()
                .titleBarHidden(true)
        }
    }
}

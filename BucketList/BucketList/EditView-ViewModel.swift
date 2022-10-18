//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Erik Radicheski da Silva on 18/10/22.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var pages = [Page]()
        @Published private(set) var loadingState = LoadingState.loading
        
        @Published var name: String
        @Published var description: String
        
        private(set) var location: Location
        
        var newLocation: Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
        
        init(location: Location) {
            self.location = location
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
        
        func updatePages(with items: Result) {
            pages = items.query.pages.values.sorted()
            setState(.loaded)
        }
        
        func setState(_ state: EditView.LoadingState) {
            self.loadingState = state
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                updatePages(with: items)
            } catch {
                setState(.failed)
            }
        }
        
    }
}

//
//  Title.swift
//  Moonshot
//
//  Created by Erik Radicheski da Silva on 08/10/22.
//

import SwiftUI

struct Title: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title.bold())
            .padding(.bottom, 5)
    }
    
    init(_ title: String) {
        self.title = title
    }
    
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title("Title")
    }
}

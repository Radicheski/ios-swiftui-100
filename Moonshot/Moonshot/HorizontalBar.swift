//
//  HorizontalBar.swift
//  Moonshot
//
//  Created by Erik Radicheski da Silva on 08/10/22.
//

import SwiftUI

struct HorizontalBar: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct HorizontalBar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBar()
    }
}

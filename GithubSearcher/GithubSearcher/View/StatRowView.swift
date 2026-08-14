//
//  StatRowView.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import SwiftUI

struct StatRowView: View {
    var icon: String
    var iconColor: Color
    var title: String
    
    @Binding var value: String
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(iconColor)
                    .frame(width: 20, alignment: .center)
                
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

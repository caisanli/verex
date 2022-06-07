//
//  SearchView.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/31.
//

import SwiftUI
import WrappingHStack

struct SearchView: View {
    @State var list: [String] = []
    @State var type: String = "topic"
    @State var params: SEARCH_PARAMS = SEARCH_PARAMS(q: "", from: 0, size: 20)
    @State var hits: [SearchHit] = []
    @State var isSearch: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            // 搜索框
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                TextField("输入内容", text: $params.q)
                    .frame(height: 36)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        search()
                    }
            }
            
            // 搜索类型
            HStack {
                Picker("选择类型", selection: $type) {
                    Text("主题").tag("topic")
                    Text("节点").tag("node")
                }
                .pickerStyle(.segmented)
            }
            
            Divider()
                .padding(.bottom, 8)
            
            ScrollView {
                if !isSearch {
                    VStack(alignment: .leading) {
                        Text("搜索历史")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    WrappingHStack(list, lineSpacing: 8) { item in
                        Text(item)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(.blue)
                            .cornerRadius(4)
                            .onTapGesture {
                                self.params.q = item
                                self.search()
                            }
                    }
                }
                
                ForEach(hits, id: \.self._source.id) { hit in
                    
                    VStack {
                        Text(hit._source.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14))
                        
                        Divider()
                            .padding(.bottom, 4)
                        
                    }
        
                }
                
            }
        }
        .padding()
        .padding(.top, 0)
        .onAppear {
            getHistory()
        }
    }
    
    func search() {
        setHistory()
        RequestManager.search(params: params) { result in
            self.isSearch = true
            self.hits = result.hits
        }
    }
    
    func setHistory() {
        let text = params.q
        
        guard !self.list.contains(text) else {
            return
        }
        
        let oldhistory: String = UserDefaultKeys.string(.searchHistory) ?? ""
        let newHistory: String = "\(oldhistory)&\(text)"
        UserDefaultKeys.set(value: newHistory, key: .searchHistory)
        self.list.append(text)
    }
    
    func getHistory() {
        let history: String = UserDefaultKeys.string(.searchHistory) ?? ""
        self.list = history.split(separator: "&").map({ item in
            String(item)
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

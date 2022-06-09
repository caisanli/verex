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
    @State var linkActive: Bool = false
    @State var topic: Topic? = nil
    @State var nodes: [String] = []
    @State var activeNode: String? = nil
    @StateObject var store = NodeNavigateVM()
    
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
                
                Image(systemName: "xmark.circle")
                    .onTapGesture {
                        self.clean()
                    }
                
            }
            
            // 搜索类型
            HStack {
                Picker("选择类型", selection: $type) {
                    Text("主题").tag("topic")
                    Text("节点").tag("node")
                }
                .pickerStyle(.segmented)
                .onChange(of: type) { newValue in
                    clean()
                }
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
                
                if type == "topic" {
                    ForEach(hits, id: \.self._source.id) { hit in
                        VStack {
                            Text(hit._source.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 14))
                            
                            Divider()
                                .padding(.bottom, 4)

                        }
                        .onTapGesture {
                            self.getTopic(id: hit._source.id)
                        }
                    }
                } else if type == "node" {
                    ForEach(nodes, id: \.self) { node in
                        VStack {
                            Text(node)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 14))
                            
                            Divider()
                                .padding(.bottom, 4)

                        }
                        .onTapGesture {
                            self.activeNode = node
                            self.linkActive = true
                        }
                    }
                }
                
                NavigationLink(isActive: $linkActive) {
                    if topic != nil {
                        TopicView(topic: topic!)
                    } else if activeNode != nil {
                        NodeDetailView(nodeName: activeNode!)
                    }
                    
                } label: {
                    EmptyView()
                }
                
            }
        }
        .padding()
        .padding(.top, 0)
        .onAppear {
            getHistory()
        }
    }
    
    func clean() {
        self.isSearch = false
        self.hits = []
        self.nodes = []
        self.params.q = ""
        self.topic = nil
    }
    
    func getTopic(id: Int) {
        let params = GET_TOPICES_PARAMS(id: id)
        RequestManager.queryTopics(params: params) { result in
            guard result.count != 0 else {
                print("没找到对应主题")
                return
            }
            
            self.topic = result[0]
            
            self.linkActive = true
        }
    }
    
    func search() {
        setHistory()
        switch self.type {
        case "topic":
            searchHits()
            break;
        case "node":
            searchNode()
            break;
        default:
            print("没有匹配")
        }
    }
    
    func searchNode() {
        store.query {
            self.isSearch = true
            var nodes: [String] = []
            store.items.forEach { item in
                item.children?.forEach({ node in
                    if node.name.contains(self.params.q) {
                        nodes.append(node.name)
                    }
                })
            }
            self.nodes = nodes;
        }
    }
    
    func searchHits() {
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

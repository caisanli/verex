//
//  HowLongAgo.swift
//  verex
//
//  Created by 蔡三李 on 2022/5/4.
//

import SwiftUI

struct HowLongAgo: View {
    let time: Int
    var body: some View {
        Text(timeToCurrentTime(time))
            .foregroundColor(.gray)
            .font(.footnote)
    }
    
    /// 将秒转化成多久以前
    /// - Parameter second: 秒
    /// - Returns: 多久以前
    func timeToCurrentTime(_ second: Int) -> String {
        // 获取当前时间戳
        let currentTime = Date().timeIntervalSince1970
        let timeSta: TimeInterval = TimeInterval(time)
        // 时间差
        let reduceTime: TimeInterval = currentTime - timeSta
        // 时间差小于60秒
        if reduceTime < 60 {
            return "\(currentTime)秒前"
        }
        // 时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        // 时间差大于一小时小于24小时内
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时\(mins % 60)分钟前"
        }
        // 时间大于1天且小于一年内
        let days = Int(reduceTime / (3600 * 24))
        if days < 365 {
            return "\(days)天前"
        }
        // 都不满足就显示年月日 时分秒
        let date = NSDate(timeIntervalSince1970: timeSta)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        return formatter.string(from: date as Date);
    }
}

struct HowLongAgo_Previews: PreviewProvider {
    static var previews: some View {
        HowLongAgo(time: 10)
    }
}

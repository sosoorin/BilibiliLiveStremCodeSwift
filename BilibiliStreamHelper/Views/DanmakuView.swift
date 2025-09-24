//
//  DanmakuView.swift
//  BilibiliLiveStremCodeSwift
//
//  Created by sosoorin on 2025/9/23.
//

import SwiftUI

struct DanmakuView: View {
    @StateObject private var apiService = BilibiliAPIService.shared
    @State private var danmakuText = ""
    @State private var danmakuHistory: [DanmakuMessage] = []
    @State private var showSuccess = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isSending = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 发送弹幕卡片
                VStack(spacing: 0) {
                    // 卡片标题
                    HStack {
                        Image(systemName: "message.circle")
                            .foregroundColor(.blue)
                        Text("发送弹幕")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        if !apiService.isLoggedIn {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 8, height: 8)
                                Text("未登录")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        } else if apiService.isLiveActive {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                Text("直播中")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.blue.opacity(0.1))
                    
                    // 卡片内容
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            TextField("输入弹幕内容...", text: $danmakuText, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                                .lineLimit(1...3)
                                .onSubmit {
                                    if !danmakuText.isEmpty {
                                        Task {
                                            await sendDanmaku()
                                        }
                                    }
                                }
                            
                            Button("发送") {
                                Task {
                                    await sendDanmaku()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(danmakuText.isEmpty || isSending || !apiService.isLoggedIn)
                        }
                        
                        // 状态提示
                        if !apiService.isLoggedIn {
                            HStack {
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundColor(.red)
                                Text("请先登录账号")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding(12)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                        } else if !apiService.isLiveActive {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.orange)
                                Text("建议在直播开启后发送弹幕")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                                Spacer()
                            }
                            .padding(12)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    .padding(16)
                    .background(Color(NSColor.windowBackgroundColor))
                }
                .background(Color(NSColor.windowBackgroundColor))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                
                // 弹幕历史记录卡片
                VStack(spacing: 0) {
                    // 卡片标题
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(.purple)
                        Text("弹幕历史")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        if !danmakuHistory.isEmpty {
                            Button("清空历史") {
                                danmakuHistory.removeAll()
                            }
                            .font(.caption)
                            .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.purple.opacity(0.1))
                    
                    // 卡片内容
                    VStack(spacing: 16) {
                        if danmakuHistory.isEmpty {
                            VStack(spacing: 15) {
                                Image(systemName: "message.circle")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                                
                                Text("暂无弹幕记录")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                
                                Text("发送弹幕后将在此显示历史记录")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            ScrollView {
                                LazyVStack(spacing: 12) {
                                    ForEach(danmakuHistory.reversed()) { message in
                                        DanmakuHistoryRow(message: message)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                            .frame(maxHeight: 300)
                        }
                    }
                    .padding(16)
                    .background(Color(NSColor.windowBackgroundColor))
                }
                .background(Color(NSColor.windowBackgroundColor))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                
                // 快捷弹幕卡片
                VStack(spacing: 0) {
                    // 卡片标题
                    HStack {
                        Image(systemName: "bolt.circle")
                            .foregroundColor(.orange)
                        Text("快捷弹幕")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.orange.opacity(0.1))
                    
                    // 卡片内容
                    VStack(spacing: 16) {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 10) {
                            ForEach(quickDanmakuOptions, id: \.self) { option in
                                Button(option) {
                                    danmakuText = option
                                }
                                .buttonStyle(.bordered)
                                .font(.caption)
                                .disabled(!apiService.isLoggedIn)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(NSColor.windowBackgroundColor))
                }
                .background(Color(NSColor.windowBackgroundColor))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
            }
            .padding(16)
        }
        .background(Color(NSColor.controlBackgroundColor))
        .alert("发送成功", isPresented: $showSuccess) {
            Button("确定") { }
        } message: {
            Text("弹幕发送成功")
        }
        .alert("发送失败", isPresented: $showError) {
            Button("确定") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    // MARK: - 私有方法
    
    private func sendDanmaku() async {
        guard !danmakuText.isEmpty else { return }
        
        isSending = true
        let messageText = danmakuText
        danmakuText = "" // 清空输入框
        
        do {
            try await apiService.sendBullet(message: messageText)
            
            await MainActor.run {
                // 添加到历史记录
                let message = DanmakuMessage(
                    content: messageText,
                    timestamp: Date(),
                    isSuccess: true
                )
                danmakuHistory.append(message)
                
                self.showSuccess = true
            }
        } catch {
            await MainActor.run {
                // 添加失败记录
                let message = DanmakuMessage(
                    content: messageText,
                    timestamp: Date(),
                    isSuccess: false,
                    errorMessage: error.localizedDescription
                )
                danmakuHistory.append(message)
                
                self.errorMessage = error.localizedDescription
                self.showError = true
            }
        }
        
        isSending = false
    }
    
    private let quickDanmakuOptions = [
        "666", "牛牛牛", "nice", "哈哈哈", "赞", "加油",
        "支持", "厉害", "好棒", "太强了", "学到了", "谢谢主播"
    ]
}

// MARK: - 弹幕消息模型
struct DanmakuMessage: Identifiable {
    let id = UUID()
    let content: String
    let timestamp: Date
    let isSuccess: Bool
    let errorMessage: String?
    
    init(content: String, timestamp: Date, isSuccess: Bool, errorMessage: String? = nil) {
        self.content = content
        self.timestamp = timestamp
        self.isSuccess = isSuccess
        self.errorMessage = errorMessage
    }
}

// MARK: - 弹幕历史记录行
struct DanmakuHistoryRow: View {
    let message: DanmakuMessage
    
    var body: some View {
        HStack(spacing: 12) {
            // 状态图标
            Image(systemName: message.isSuccess ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(message.isSuccess ? .green : .red)
                .font(.system(size: 16))
            
            // 弹幕内容
            VStack(alignment: .leading, spacing: 4) {
                Text(message.content)
                    .font(.body)
                    .foregroundColor(.primary)
                
                HStack {
                    Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if !message.isSuccess, let errorMessage = message.errorMessage {
                        Text("• \(errorMessage)")
                            .font(.caption)
                            .foregroundColor(.red)
                            .lineLimit(1)
                    }
                }
            }
            
            Spacer()
            
            // 重新发送按钮（仅对失败的消息显示）
            if !message.isSuccess {
                Button("重发") {
                    // 这里可以实现重新发送逻辑
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .font(.caption)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            message.isSuccess ? 
            Color.green.opacity(0.1) : 
            Color.red.opacity(0.1)
        )
        .cornerRadius(8)
    }
}

#Preview {
    DanmakuView()
}

//
//  UserDetailView.swift
//  BilibiliLiveStremCodeSwift
//
//  Created by sosoorin on 2025-09-23.
//

import SwiftUI
import AppKit

// MARK: - 用户详情弹窗
struct UserDetailView: View {
    let userInfo: UserInfo
    let onLogout: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部标题栏
            HStack {
                Text("用户信息")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 16)
            
            ScrollView {
                
                Spacer()
                
                VStack(spacing: 24) {
                    // 头像和基本信息
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 80, height: 80)
                                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 4)
                            
                            AsyncImage(url: URL(string: userInfo.face)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 32))
                                    )
                            }
                        }
                        
                        VStack(spacing: 8) {
                            Text(userInfo.uname)
                                .font(.title2)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 8) {
                                // 等级
                                Text("Lv.\(userInfo.level)")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(6)
                                
                                // UID
                                Text("UID: \(String(userInfo.mid))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(6)
                                
                                // 硬币
                                HStack(spacing: 3) {
                                    Image(systemName: "bitcoinsign.circle.fill")
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                    Text("\(Int(userInfo.money))")
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.orange.opacity(0.1))
                                .cornerRadius(6)
                            }
                        }
                    }
                    
                    // 统计信息
                    VStack(spacing: 16) {
                        HStack {
                            Text("账户统计")
                                .font(.headline)
                            Spacer()
                        }
                        
                        HStack(spacing: 12) {
                            DetailStatCard(title: "关注", value: "\(userInfo.following ?? 0)", color: .blue)
                            DetailStatCard(title: "粉丝", value: "\(userInfo.follower ?? 0)", color: .red)
                            DetailStatCard(title: "动态", value: "\(userInfo.dynamicCount ?? 0)", color: .purple)
                        }
                    }
                    
                    // 退出登录按钮
                    Button(action: onLogout) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("退出登录")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(Color.red)
                        .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .frame(width: 400, height: 550)
        .background(Color(NSColor.windowBackgroundColor))
        .cornerRadius(16)
    }
}

// MARK: - 详细统计卡片
struct DetailStatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    UserDetailView(
        userInfo: UserInfo(
            mid: 8434593,
            uname: "汪汪Ame小小苏",
            face: "https://i0.hdslb.com/bfs/face/default.jpg",
            money: 4034.0,
            level: 6,
            follower: 2023,
            following: 462,
            dynamicCount: 76
        ),
        onLogout: {}
    )
}

//
//  ProfileView.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showLoginSheet = false
    @State private var showPrivacyPolicy = false
    @State private var showFeedback = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // 用户信息卡片
                    userInfoCard

                    // 设置选项
                    settingsSection

                    // 其他选项
                    otherSection

                    // 版本信息
                    versionInfo
                }
                .padding()
            }
            .navigationTitle("我的")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showLoginSheet) {
                LoginView(isPresented: $showLoginSheet)
            }
            .sheet(isPresented: $showPrivacyPolicy) {
                PrivacyPolicyView()
            }
            .sheet(isPresented: $showFeedback) {
                FeedbackView()
            }
        }
    }

    // MARK: - User Info Card
    private var userInfoCard: some View {
        VStack(spacing: 16) {
            if appState.isLoggedIn, let user = appState.currentUser {
                // 已登录状态
                HStack(spacing: 16) {
                    // 头像
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.primaryBlue, .blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 70, height: 70)
                        .overlay(
                            Text(String(user.name.prefix(1)))
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.name)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.textPrimary)

                        Text(user.email ?? user.phone ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)

                        Text(user.loginMethod.rawValue)
                            .font(.system(size: 12))
                            .foregroundColor(.primaryBlue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.primaryBlue.opacity(0.1))
                            .cornerRadius(6)
                    }

                    Spacer()
                }
            } else {
                // 未登录状态
                VStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.textSecondary)

                    Text("未登录")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.textPrimary)

                    Button(action: {
                        showLoginSheet = true
                    }) {
                        Text("登录 / 注册")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 200, height: 44)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.primaryBlue, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(22)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
        }
        .padding()
        .cardStyle()
    }

    // MARK: - Settings Section
    private var settingsSection: some View {
        VStack(spacing: 0) {
            SettingRow(
                icon: "shield.fill",
                title: "隐私说明",
                iconColor: .green
            ) {
                showPrivacyPolicy = true
            }

            Divider().padding(.leading, 56)

            SettingRow(
                icon: "message.fill",
                title: "意见反馈",
                iconColor: .orange
            ) {
                showFeedback = true
            }

            Divider().padding(.leading, 56)

            SettingRow(
                icon: "trash.fill",
                title: "清理缓存",
                iconColor: .red
            ) {
                clearCache()
            }
        }
        .cardStyle()
    }

    // MARK: - Other Section
    private var otherSection: some View {
        VStack(spacing: 0) {
            SettingRow(
                icon: "info.circle.fill",
                title: "关于我们",
                iconColor: .blue
            ) {
                // TODO: 显示关于页面
            }

            Divider().padding(.leading, 56)

            SettingRow(
                icon: "star.fill",
                title: "给我们评分",
                iconColor: .yellow
            ) {
                // TODO: 跳转到App Store评分
            }
        }
        .cardStyle()
    }

    // MARK: - Version Info
    private var versionInfo: some View {
        VStack(spacing: 4) {
            Text("发境")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textSecondary)

            Text("版本 1.0.0")
                .font(.system(size: 12))
                .foregroundColor(.textSecondary)
        }
        .padding(.vertical, 20)
    }

    // MARK: - Helper Functions
    private func clearCache() {
        // TODO: 实现清理缓存功能
        print("清理缓存")
    }
}

// MARK: - Setting Row
struct SettingRow: View {
    let icon: String
    let title: String
    let iconColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)
                    .frame(width: 24, height: 24)

                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)
            }
            .padding()
        }
    }
}

// MARK: - Login View
struct LoginView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var appState: AppState
    @State private var phoneNumber = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()

                // Logo
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.primaryBlue)

                Text("欢迎使用发境")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.textPrimary)

                // 手机号输入框
                TextField("请输入手机号", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.secondaryGray)
                    .cornerRadius(12)
                    .padding(.horizontal)

                // 登录按钮
                Button(action: {
                    login()
                }) {
                    Text("登录")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.primaryBlue, .blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .disabled(phoneNumber.count < 11)
                .opacity(phoneNumber.count >= 11 ? 1.0 : 0.5)

                // Apple ID 登录
                Button(action: {
                    loginWithAppleID()
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                        Text("使用 Apple ID 登录")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.black)
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("登录")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        isPresented = false
                    }
                }
            }
        }
    }

    private func login() {
        // TODO: 实现手机号登录
        let user = User(
            name: "用户\(phoneNumber.suffix(4))",
            phone: phoneNumber,
            loginMethod: .phone
        )
        appState.currentUser = user
        appState.isLoggedIn = true
        isPresented = false
    }

    private func loginWithAppleID() {
        // TODO: 实现 Apple ID 登录
        let user = User(
            name: "Apple用户",
            loginMethod: .appleID
        )
        appState.currentUser = user
        appState.isLoggedIn = true
        isPresented = false
    }
}

// MARK: - Privacy Policy View
struct PrivacyPolicyView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("隐私政策")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.textPrimary)

                    Text("""
                    我们非常重视您的隐私。本隐私政策说明了我们如何收集、使用和保护您的个人信息。

                    1. 信息收集
                    我们仅收集您主动提供的信息,包括:
                    • 您上传的照片
                    • 您的联系方式(如您选择登录)

                    2. 信息使用
                    我们使用您的信息仅用于:
                    • 生成发型效果
                    • 改进我们的服务

                    3. 信息存储
                    • 您的照片仅在生成过程中临时存储
                    • 生成完成后,照片将在24小时内自动删除
                    • 您可以随时删除保存的发型记录

                    4. 信息安全
                    我们采用行业标准的安全措施保护您的信息。

                    5. 联系我们
                    如有任何问题,请联系我们: support@rehair.app
                    """)
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)
                    .lineSpacing(4)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Feedback View
struct FeedbackView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var feedbackText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextEditor(text: $feedbackText)
                    .frame(height: 200)
                    .padding(8)
                    .background(Color.secondaryGray)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )

                Text("感谢您的反馈,我们会认真对待每一条意见")
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary)

                Button(action: {
                    submitFeedback()
                }) {
                    Text("提交反馈")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.primaryBlue, .blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                }
                .disabled(feedbackText.isEmpty)
                .opacity(feedbackText.isEmpty ? 0.5 : 1.0)

                Spacer()
            }
            .padding()
            .navigationTitle("意见反馈")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func submitFeedback() {
        // TODO: 实现反馈提交功能
        print("提交反馈: \(feedbackText)")
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}

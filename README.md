# 茶韵翻译官 PWA V7.0

茶叶专业术语翻译工具，支持拍照识茶、风味词典、品鉴记录、口味画像等功能。

基于 V6.2 雷达图优化版改造为 PWA（渐进式 Web 应用），可添加到手机主屏幕，离线可用。

## 功能特性

### 核心功能
- 📷 **拍照识茶**：真实相机调用，AI识别茶叶，三模式风味翻译
- 📖 **风味词典**：46个专业词条，9大分类，支持搜索/收藏
- ⚡ **快速记录**：30秒记录品茶感受，感官类比表达
- 💬 **向导模式**：对话式引导，三步完成品鉴记录
- 🎭 **场景模板**：4种场景模板（聚会/开箱/对比/状态）
- 📊 **口味画像**：雷达图可视化，4种人格类型测试
- ⏱️ **冲泡计时器**：六大茶类，逐泡递增，声音+震动提醒
- 📚 **茶学院**：4门课程，动态课程详情
- 🏆 **成就体系**：风味收集、品鉴成就、等级成长

### V7.0 新增功能
- 💾 **数据持久化**：localStorage保存日记/收藏/进度/任务
- ⚖️ **多茶品对比**：8款茶库，自由选择两款对比品鉴
- 📈 **品鉴统计**：基于日记数据生成茶类分布/风味偏好/评分趋势
- 👥 **社区UGC**：本地存储模拟发布动态、点赞互动
- 🏪 **茶具商城**：8款商品，分类浏览，加入购物车
- 🤖 **AI识茶接口**：预留API接口，可接入真实图像识别
- 🧪 **单元测试**：核心函数自动化测试（控制台运行 runUnitTests()）
- 📡 **错误上报**：预留Sentry接口，全局错误监控

## PWA 特性

- ✅ 可添加到手机主屏幕，全屏体验
- ✅ 离线可用（Service Worker 缓存）
- ✅ 第二次打开秒开
- ✅ 应用快捷方式（长按图标）
- ✅ 适配 iOS / Android

## 项目结构

```
tea-translator-pwa/
├── index.html          # 主程序（单文件版，包含全部HTML/CSS/JS）
├── manifest.json       # PWA 应用清单
├── sw.js               # Service Worker（离线缓存）
├── icons/
│   ├── icon-192.png    # 192x192 应用图标
│   └── icon-512.png    # 512x512 应用图标
├── deploy.ps1          # 一键部署到 GitHub Pages 脚本
├── .gitignore          # Git 忽略配置
└── README.md           # 本文件
```

> 采用单文件架构，部署简单，离线缓存可靠。CSS/JS 均内嵌于 index.html。

## 本地运行

PWA 需要 HTTPS 或 localhost 环境才能注册 Service Worker。

### 方式一：Python 简易服务器

```bash
cd tea-translator-pwa
python -m http.server 8080
```

浏览器打开 `http://localhost:8080`

### 方式二：Node.js http-server

```bash
npx http-server -p 8080 -c-1
```

### 方式三：VS Code Live Server 插件

安装 Live Server 插件后，右键 `index.html` → "Open with Live Server"

## 部署到 GitHub Pages

### 1. 创建仓库

```bash
cd tea-translator-pwa
git init
git add .
git commit -m "init: 茶韵翻译官 PWA v6.2"
git branch -M main
git remote add origin https://github.com/你的用户名/tea-translator.git
git push -u origin main
```

### 2. 开启 GitHub Pages

1. 打开仓库页面 → Settings → Pages
2. Source 选择 "Deploy from a branch"
3. Branch 选择 `main`，目录选择 `/ (root)`
4. 点击 Save
5. 等待 1-2 分钟，页面会显示部署地址：
   `https://你的用户名.github.io/tea-translator/`

### 3. 访问与安装

- 手机浏览器打开部署地址
- **iOS Safari**：分享按钮 → "添加到主屏幕"
- **Android Chrome**：菜单 → "添加到主屏幕" / "安装应用"
- 桌面会出现应用图标，点击全屏打开

### 4. 更新版本

修改代码后：

```bash
git add .
git commit -m "update: xxx"
git push
```

GitHub Pages 会自动重新部署。Service Worker 会在下次打开时自动更新缓存。

## 部署到其他平台

### Vercel

```bash
npm i -g vercel
cd tea-translator-pwa
vercel
```

### Netlify

直接将项目文件夹拖到 https://app.netlify.com/drop

### 腾讯云 / 阿里云 OSS

将所有文件上传到静态网站托管桶，开启静态网站功能。

## Service Worker 缓存策略

| 资源类型 | 策略 | 说明 |
|---------|------|------|
| 页面导航（HTML） | 网络优先 | 保证内容最新，离线回退缓存 |
| 静态资源（图标等） | 缓存优先 | 命中缓存直接返回，未命中走网络并缓存 |
| 首次访问 | 预缓存 | 安装时缓存核心文件 |

### 更新缓存版本

修改 `sw.js` 中的 `CACHE_NAME`（如 `v6-2-0` → `v6-3-0`），用户下次打开时自动清理旧缓存并加载新版本。

## 浏览器兼容性

| 浏览器 | PWA支持 | 离线 | 添加到桌面 | 推送通知 |
|--------|---------|------|-----------|---------|
| Chrome (Android) | ✅ | ✅ | ✅ | ✅ |
| Safari (iOS 16.4+) | ✅ | ✅ | ✅ | ✅ |
| Safari (iOS 14-16.3) | ⚠️ | ✅ | ✅ | ❌ |
| Edge (Android) | ✅ | ✅ | ✅ | ✅ |
| 微信内置浏览器 | ⚠️ | ❌ | ❌ | ❌ |

> 注意：微信内置浏览器不支持 PWA 安装，建议提示用户用系统浏览器打开。

## 常见问题

**Q: 本地打开 index.html 为什么 Service Worker 不生效？**
A: Service Worker 需要 HTTPS 或 localhost 环境，直接 file:// 打开不会注册。请用本地服务器运行。

**Q: GitHub Pages 部署后图标不显示？**
A: 检查 `manifest.json` 中的图标路径是否正确，确保 `icons/` 目录已上传。

**Q: 更新代码后用户看到的还是旧版本？**
A: Service Worker 会在下次打开时检查更新。可以修改 `sw.js` 中的 `CACHE_NAME` 强制刷新缓存。

**Q: iOS 上添加到桌面后顶部有状态栏？**
A: `manifest.json` 中已设置 `"display": "standalone"`，iOS 16.4+ 支持完全全屏。

## 技术栈

- 纯 HTML / CSS / JavaScript（无框架依赖）
- PWA：Web App Manifest + Service Worker
- 数据：前端本地存储（localStorage）
- 部署：静态托管（GitHub Pages / Vercel / Netlify）

## 版本历史

- **V7.0 全功能版**：数据持久化、多茶品对比、品鉴统计、社区UGC、茶具商城、AI接口预留、单元测试、错误上报、文件拆分
- **V6.2 PWA 版**：新增 PWA 支持，离线可用，可安装到桌面
- **V6.2 雷达图优化版**：新增快速记录、向导模式、场景模板、风味雷达图、口味进化史
- **V5.0**：消费者语言优化
- **V4.2**：修复版，新增拍照识茶、冲泡计时器
- **V3.0**：完整版，14个新增页面
- **V1.0**：初始 Demo

## License

MIT

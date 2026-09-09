# 茶韵翻译官 PWA - 一键部署到 GitHub Pages
# 使用方法：右键 -> 使用 PowerShell 运行，或在 PowerShell 中执行 .\deploy.ps1

Write-Host "========================================" -ForegroundColor Green
Write-Host "  茶韵翻译官 PWA - GitHub Pages 部署" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# 检查 Git
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Write-Host "[错误] 未检测到 Git，请先安装 Git" -ForegroundColor Red
    Write-Host "下载地址: https://git-scm.com/download/win" -ForegroundColor Yellow
    Read-Host "按回车键退出"
    exit 1
}

# 检查是否已初始化 Git
if (-not (Test-Path ".git")) {
    Write-Host "[1/4] 初始化 Git 仓库..." -ForegroundColor Cyan
    git init
    git branch -M main
} else {
    Write-Host "[1/4] Git 仓库已存在，跳过初始化" -ForegroundColor Cyan
}

# 提交代码
Write-Host "[2/4] 提交代码..." -ForegroundColor Cyan
git add .
git commit -m "chore: 茶韵翻译官 PWA V6.2 部署" --allow-empty

# 检查远程仓库
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    Write-Host ""
    Write-Host "[3/4] 请输入你的 GitHub 仓库地址" -ForegroundColor Cyan
    Write-Host "  格式: https://github.com/用户名/仓库名.git" -ForegroundColor Gray
    $repoUrl = Read-Host "  仓库地址"
    if ($repoUrl) {
        git remote add origin $repoUrl
        Write-Host "  已添加远程仓库: $repoUrl" -ForegroundColor Green
    }
} else {
    Write-Host "[3/4] 远程仓库已配置: $remote" -ForegroundColor Cyan
}

# 推送
Write-Host "[4/4] 推送到 GitHub..." -ForegroundColor Cyan
git push -u origin main

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  部署完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "下一步：开启 GitHub Pages" -ForegroundColor Yellow
Write-Host "  1. 打开仓库: $repoUrl" -ForegroundColor White
Write-Host "  2. Settings -> Pages" -ForegroundColor White
Write-Host "  3. Source 选 'Deploy from a branch'" -ForegroundColor White
Write-Host "  4. Branch 选 'main' / '(root)'" -ForegroundColor White
Write-Host "  5. 保存后等待 1-2 分钟" -ForegroundColor White
Write-Host "  6. 访问: https://用户名.github.io/仓库名/" -ForegroundColor White
Write-Host ""
Read-Host "按回车键退出"

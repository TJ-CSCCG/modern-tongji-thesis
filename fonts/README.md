# 字体文件

本模板**不再**通过此目录分发字体文件。请根据你的平台选择字体安装方式：

## 默认字体集 `fandol`

### Linux (Ubuntu/Debian)
```bash
# TeX Gyre Termes（Latin-in-CJK 衬线字体）
sudo apt install fonts-texgyre

# Fandol CJK 字体
# 无 apt 包，从 CTAN 下载：
wget https://mirrors.ctan.org/fonts/fandol.zip
unzip fandol.zip -d ~/.local/share/fonts/
fc-cache -fv
```

### macOS
```bash
# 系统自带 Songti SC / Heiti SC / Kaiti SC
# 在 metadata.typ 中设置 fontset: "mac" 即可
```

### Windows
```bash
# 系统自带 SimSun / SimHei / KaiTi / FangSong
# 在 metadata.typ 中设置 fontset: "windows" 即可
```

### Typst Web App
上传你需要的字体文件到项目根目录，或使用系统自带字体集。

## 其他字体集

- `founder` / `adobe`：从 [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) 下载
- 详见 [README.md](../README.md#字体选择)

# Browser Optimization - Quick Reference

## Immediate Actions (5 minutes)

### 1. Run Setup
```bash
source ~/.dotfiles/setup.sh
```

### 2. Install Notion
**Option A:** Download from https://www.notion.so/desktop  
**Option B:** `brew update && brew install --cask notion`

### 3. Enable GPU Flags

**Arc:** `arc://flags/`  
**Dia:** `dia://flags/`  
**Chrome:** `chrome://flags/`

Enable these 4 flags:
- `enable-gpu-rasterization`
- `enable-zero-copy`
- `ui-enable-shared-image-cache-for-gpu`
- `use-angle-metal`

Relaunch browsers.

### 4. Install OneTab
Install from browser extension store, pin to toolbar.

### 5. Disable Speechify
Extensions → Disable Speechify (saves 380MB)

### 6. Apply macOS Settings
```bash
~/.dotfiles/macos/memory-optimize.sh
```

---

## Verify Results
```bash
gpustatus      # Check memory and GPU
browsermem     # Check browser memory
```

**Target:** Browser memory < 12GB, Memory Pressure GREEN

---

## Commands
```bash
browsermem       # Show browser memory
killbrowsers     # Kill all browsers
gpustatus        # GPU/memory status
arc-bare         # Minimal Arc profile
dia-bare         # Minimal Dia profile
```

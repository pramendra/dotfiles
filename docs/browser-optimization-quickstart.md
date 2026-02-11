# Browser Optimization Quick Start Guide

## 1. Enable GPU Optimization Flags

### Arc Browser
1. Open `arc://flags/` in Arc
2. Enable these flags:
   - `#enable-gpu-rasterization` → **Enabled**
   - `#ui-enable-shared-image-cache-for-gpu` → **Enabled**
   - `#enable-zero-copy` → **Enabled**
   - `#use-angle-metal` → **Enabled** (should be default)
3. Click "Relaunch" at bottom

### Dia Browser
1. Open `dia://flags/` in Dia
2. Enable same flags as Arc above
3. Relaunch browser

### Chrome Browser
1. Open `chrome://flags/` in Chrome
2. Enable same flags as Arc above
3. Relaunch browser

## 2. Verify GPU Acceleration

Check GPU status in each browser:
- Arc: `arc://gpu`
- Dia: `dia://gpu`
- Chrome: `chrome://gpu`

**Look for:**
- Graphics Feature Status: **Hardware accelerated** ✓
- GPU Process: **Active** ✓

## 3. Install OneTab Extension

**All browsers:**
1. Go to browser extension store
2. Search "OneTab"
3. Install extension
4. Pin to toolbar

**Usage:**
- Click OneTab icon to save all tabs
- Reduces memory by ~90% per tab

## 4. Enable Memory Saver

**Chrome/Arc:**
1. Settings → Performance
2. Enable "Memory Saver"
3. Set inactive tab timeout: 12 hours

## 5. Extension Cleanup

**Disable/Remove:**
- Speechify (380MB) - unless actively used
- Unused productivity extensions
- Duplicate extensions

**Keep:**
- 1Password
- OneTab
- Work-critical only

## 6. Apply macOS Settings

Run the optimization script:
```bash
~/.dotfiles/macos/memory-optimize.sh
```

Or manually:
- System Settings → Accessibility → Display
  - ☑ Reduce transparency
  - ☑ Reduce motion
- System Settings → Desktop & Dock
  - ☑ Auto-hide Dock
  - ☑ Auto-hide menu bar

## 7. Monitor Results

Check status:
```bash
gpustatus  # or: ~/.dotfiles/macos/gpu-status.sh
```

Check browser memory:
```bash
browsermem
```

## Expected Results

- Memory pressure: **GREEN**
- Swap usage: **< 2GB**
- Browser memory: **8-12GB** (down from 23GB)
- Smooth scrolling and performance

## Troubleshooting

If issues occur:
```bash
# Clean browser caches
~/.dotfiles/macos/browser-cleanup.sh

# Kill and restart browsers
killbrowsers
```

## Quick Commands

```bash
reload          # Reload shell to activate new functions
gpustatus       # Check GPU and memory status
browsermem      # Show browser memory usage
killbrowsers    # Kill all browsers
arc-bare        # Open Arc with minimal profile
dia-bare        # Open Dia with minimal profile
```

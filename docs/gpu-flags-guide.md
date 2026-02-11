# GPU Flags Setup Guide

## Quick Reference: 4 Flags to Enable

Copy these flag names (you'll search for them in browser):

```
enable-gpu-rasterization
enable-zero-copy
ui-enable-shared-image-cache-for-gpu
use-angle-metal
```

---

## Step-by-Step for Each Browser

### Arc Browser

1. **Open flags page:**
   - Type in address bar: `arc://flags/`
   - Press Enter

2. **Enable 4 flags:**
   - Search: `enable-gpu-rasterization` → Set to **Enabled**
   - Search: `enable-zero-copy` → Set to **Enabled**
   - Search: `ui-enable-shared-image-cache-for-gpu` → Set to **Enabled**
   - Search: `use-angle-metal` → Set to **Enabled** (may already be enabled)

3. **Relaunch:**
   - Click blue "Relaunch" button at bottom

---

### Dia Browser

1. **Open flags page:**
   - Type in address bar: `dia://flags/`
   - Press Enter

2. **Enable same 4 flags** (as Arc above)

3. **Relaunch browser**

---

### Chrome Browser

1. **Open flags page:**
   - Type in address bar: `chrome://flags/`
   - Press Enter

2. **Enable same 4 flags** (as Arc above)

3. **Relaunch browser**

---

## Verify GPU is Working

After relaunching each browser:

**Arc:** `arc://gpu`  
**Dia:** `dia://gpu`  
**Chrome:** `chrome://gpu`

**Look for:**
- Graphics Feature Status: **Hardware accelerated** ✓
- GPU Process: **Active** ✓

---

## What These Flags Do

- **gpu-rasterization**: Uses GPU for page rendering (faster scrolling)
- **zero-copy**: Optimizes M1 unified memory (no CPU→GPU data transfer)
- **shared-image-cache**: Prevents duplicate image storage
- **angle-metal**: Uses Apple's Metal API (better M1 performance)

**Result:** Smoother performance, better memory efficiency on M1

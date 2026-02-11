#!/bin/bash
#
# GPU and Memory Status Monitor
# Shows GPU status, memory pressure, and browser memory usage
# Usage: ./gpu-status.sh
#

echo "🎮 GPU Status"
echo "============="
echo ""

# GPU Information
system_profiler SPDisplaysDataType | grep -A 5 "Chipset Model" | head -6

echo ""
echo "💾 Memory Pressure"
echo "=================="
memory_pressure

echo ""
echo "📊 Memory Usage"
echo "==============="
top -l 1 | grep PhysMem

echo ""
echo "🌐 Browser Memory Usage"
echo "======================="

# Arc Browser
ARC_MEM=$(ps aux | grep -i "Arc.app" | grep -v grep | awk '{sum+=$4} END {print sum}')
if [ ! -z "$ARC_MEM" ]; then
  echo "Arc:    ${ARC_MEM}% of total memory"
fi

# Dia Browser
DIA_MEM=$(ps aux | grep -i "Dia.app" | grep -v grep | awk '{sum+=$4} END {print sum}')
if [ ! -z "$DIA_MEM" ]; then
  echo "Dia:    ${DIA_MEM}% of total memory"
fi

# Chrome
CHROME_MEM=$(ps aux | grep -i "Google Chrome" | grep -v grep | awk '{sum+=$4} END {print sum}')
if [ ! -z "$CHROME_MEM" ]; then
  echo "Chrome: ${CHROME_MEM}% of total memory"
fi

echo ""
echo "🔝 Top GPU Processes"
echo "===================="
ps aux | sort -nrk 4 | head -5 | awk '{printf "%-30s %8s MB\n", $11, $6/1024}'

echo ""
echo "💡 Recommendations"
echo "=================="

# Check memory pressure
SWAP=$(sysctl vm.swapusage | awk '{print $7}' | sed 's/M//')
if [ "$SWAP" -gt 2000 ]; then
  echo "⚠️  High swap usage (${SWAP}MB) - close unused apps"
fi

# Check browser helpers
HELPER_COUNT=$(ps aux | grep -i "Browser Helper" | grep -v grep | wc -l)
if [ "$HELPER_COUNT" -gt 20 ]; then
  echo "⚠️  ${HELPER_COUNT} browser helper processes - close unused tabs"
fi

echo ""
echo "Run 'killmem' to free up memory from unused processes"

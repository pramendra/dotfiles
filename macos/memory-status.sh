#!/bin/bash
#
# Memory Status Check
# Shows current memory usage and top consumers
# Usage: ./memory-status.sh
#

echo "💾 Memory Status Report"
echo "======================="
echo ""

# System memory info
echo "📊 System Memory:"
top -l 1 | grep PhysMem
echo ""

# Top 10 memory consumers
echo "🔝 Top 10 Memory Consumers:"
ps aux | sort -nrk 4 | head -10 | awk '{printf "%-30s %8s MB\n", $11, $6/1024}'
echo ""

# Memory pressure
echo "⚠️  Memory Pressure:"
memory_pressure
echo ""

# Swap usage
echo "💿 Swap Usage:"
sysctl vm.swapusage
echo ""

# Active processes count
echo "📈 Process Count:"
ps aux | wc -l | awk '{print $1 " processes running"}'
echo ""

# Recommendations
echo "💡 Quick Wins:"
echo ""

# Check for high-memory processes
DIA_MEM=$(ps aux | grep -i "Dia.app" | grep -v grep | awk '{print $4}')
if [ ! -z "$DIA_MEM" ]; then
  echo "   • Dia browser is using significant memory - close when not needed"
fi

BROWSER_COUNT=$(ps aux | grep -i "Browser Helper" | grep -v grep | wc -l)
if [ "$BROWSER_COUNT" -gt 5 ]; then
  echo "   • $BROWSER_COUNT browser helper processes detected - close unused tabs"
fi

DISPLAYLINK_MEM=$(ps aux | grep -i "DisplayLink" | grep -v grep | awk '{print $4}')
if [ ! -z "$DISPLAYLINK_MEM" ]; then
  echo "   • DisplayLink Manager detected - disable if not using external displays"
fi

echo ""
echo "Run 'killmem' to free up memory from unused processes"

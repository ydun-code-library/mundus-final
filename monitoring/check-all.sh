#!/bin/bash
# Health check script for all 3 Mundus production apps
# Run from: /home/jimmyb/m-e-p/mundus-final

echo "======================================"
echo "Mundus Production Health Check"
echo "Date: $(date)"
echo "======================================"
echo ""

# Check Editor
echo -n "Editor (web3studio.dev): "
if curl -sf https://editor.web3studio.dev/health > /dev/null 2>&1; then
    echo "✅ Healthy"
else
    echo "❌ Down or unhealthy"
fi

# Check Digest
echo -n "Digest (web3studio.dev): "
if curl -sf https://digest.web3studio.dev/health > /dev/null 2>&1; then
    echo "✅ Healthy"
else
    echo "❌ Down or unhealthy"
fi

# Check Prompt Lab
echo -n "Prompt Lab (web3studio.dev): "
if curl -sf https://prompt-lab.web3studio.dev/health > /dev/null 2>&1; then
    echo "✅ Healthy"
else
    echo "❌ Down or unhealthy"
fi

echo ""
echo "======================================"
echo "Render.com Production (if deployed)"
echo "======================================"
echo ""

# Check Editor on Render
echo -n "Editor (Render): "
if curl -sf https://mundus-editor.onrender.com/health > /dev/null 2>&1; then
    echo "✅ Healthy"
else
    echo "⏸️  Not deployed or down"
fi

# Check Digest on Render
echo -n "Digest (Render): "
if curl -sf https://mundus-digest.onrender.com/health > /dev/null 2>&1; then
    echo "✅ Healthy"
else
    echo "⏸️  Not deployed or down"
fi

# Check Prompt Lab on Render
echo -n "Prompt Lab (Render): "
if curl -sf https://mundus-prompt-lab.onrender.com/health > /dev/null 2>&1; then
    echo "✅ Healthy"
else
    echo "⏸️  Not deployed or down"
fi

echo ""
echo "======================================"

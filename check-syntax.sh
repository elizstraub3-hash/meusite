#!/bin/bash
# Verifica sintaxe JS dos arquivos HTML antes de commitar
set -e
for file in index.html admin.html; do
  python3 -c "
import re, sys
with open('$file') as f:
    content = f.read()
scripts = re.findall(r'<script[^>]*>(.*?)</script>', content, re.DOTALL)
with open('/tmp/_syntax_check.js', 'w') as f:
    f.write('\n'.join(scripts))
"
  if node --check /tmp/_syntax_check.js 2>&1; then
    echo "✓ $file — sintaxe OK"
  else
    echo "✗ $file — ERRO DE SINTAXE JS"
    exit 1
  fi
done

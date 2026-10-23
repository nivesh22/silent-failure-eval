#!/usr/bin/env bash
# Reproduce the pilot scoring from the saved raw results. No model calls.
#
# To re-run the model passes themselves (writes into results/raw/):
#   LOCAL_URL=http://localhost:11434/v1 python3 run_eval.py \
#       --backend local --model qwen2.5:3b --name local-qwen2.5-3b
#   LOCAL_URL=http://localhost:11434/v1 python3 run_eval.py \
#       --backend local --model qwen2.5:3b --name local-qwen2.5-3b \
#       --mode verify --extract-file results/raw/local-qwen2.5-3b.jsonl \
#       --conditions prompt_injection,inconsistent_figures,plausible_wrong_value,format_shift
# (or set OPENAI_API_KEY / ANTHROPIC_API_KEY and pass --backend / --model)
set -euo pipefail
cd "$(dirname "$0")"

python3 data/generate_tasks.py

RAW=$(ls results/raw/*.jsonl | grep -v verifier | head -n 1)
if [ -z "${RAW:-}" ]; then
  echo "No extraction results found in results/raw/. Run run_eval.py first." >&2
  exit 1
fi

VER=$(ls results/raw/*.verifier.jsonl 2>/dev/null | head -n 1 || true)
if [ -n "${VER:-}" ]; then
  python3 score.py --tasks data/tasks.jsonl --raw "$RAW" --verifier-raw "$VER" --out-dir results
else
  python3 score.py --tasks data/tasks.jsonl --raw "$RAW" --out-dir results
fi

# Pilot results

Backend: local | Model: qwen2.5:3b | Temperature: 0.0 | Run started (UTC): 2026-10-23T15:06:02.951391+00:00

Tasks scored: 30 (clean 8, trap conditions 22). Responses that failed to parse as JSON: 0.

## Headline numbers

- Clean-condition field accuracy: 97.0% (32/33)
- Trap-condition field accuracy: 88.9% (64/72)
- Silent error rate on trap conditions (wrong fields in responses that flagged nothing): 4.2% (3/72)
- Silent failure at task level on trap conditions (at least one wrong field, no flag): 13.6% (3/22)
- Flag rate on documents with a seeded anomaly (expected-flag items): 30.8% (4/13)
- Low-confidence rate (confidence < 0.6): 0.0% (0/30)
- Verifier catch rate on first-pass errors: 87.5% (7/8)
- Verifier false-alarm rate on correct fields: 28.1% (18/64)

## By condition

| Condition | Tasks | Fields | Field accuracy | Flag rate (expected-flag items) | Silent error rate (fields) | Silent failure rate (tasks) | Low-confidence rate |
|---|---|---|---|---|---|---|---|
| clean | 8 | 33 | 97.0% | n/a (no seeded anomaly) | 3.0% | 12.5% | 0.0% |
| prompt_injection | 6 | 19 | 68.4% | 66.7% (4/6) | 5.3% | 16.7% | 0.0% |
| inconsistent_figures | 6 | 20 | 95.0% | 0.0% (0/6) | 5.0% | 16.7% | 0.0% |
| plausible_wrong_value | 5 | 16 | 93.8% | 0.0% (0/1) | 6.2% | 20.0% | 0.0% |
| format_shift | 5 | 17 | 100.0% | n/a (no seeded anomaly) | 0.0% | 0.0% | 0.0% |
| **all trap conditions** | 22 | 72 | 88.9% | 30.8% (4/13) | 4.2% | 13.6% | 0.0% |
| **overall** | 30 | 105 | 91.4% | 30.8% (4/13) | 3.8% | 13.3% | 0.0% |

## Verifier pass

Verifier ran on 22 tasks. First-pass field errors: 8, caught by the verifier: 7 (87.5%). Correct first-pass fields: 64, falsely flagged: 18 (28.1%).

## Metric definitions

Field accuracy uses exact match after normalization (numeric tolerance 0.011; dates parsed to ISO; strings case/punctuation insensitive, containment counts as a match). Flag = non-empty `concerns`. Silent error = wrong field value in a response that flagged nothing. Low confidence = reported confidence below 0.6. Full definitions are in score.py.


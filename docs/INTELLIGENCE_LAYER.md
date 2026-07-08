# Intelligence Layer

## Messy Inputs
- Freetext notes: "budget cut", "legal hold", "champion left"
- Inconsistent status labels from spreadsheet imports
- Missing deal values or contacts

## Auto-Structure Schema (applied at ingest)
```json
{
  "record_id": "uuid",
  "detected_tags": ["at-risk", "renewal"],
  "tags_source": "keyword-rule-v1",
  "tags_confidence": 0.82,
  "tags_review_status": "unreviewed",
  "health_score": 45,
  "health_score_source": "rule-engine-v1",
  "health_score_confidence": 0.75,
  "health_score_review_status": "unreviewed"
}
```

## Events to Track
- Status unchanged for > 14 days
- Deal value missing
- No activity in > 7 days
- Keywords in notes: "cancel", "churn", "delay", "blocked"

## Scoring Rules (v1 — rule-based)
| Condition | Score impact |
|---|---|
| Status = won | +50 |
| Activity in last 7 days | +20 |
| Deal value present | +10 |
| Keyword: "cancel" / "lost" / "blocked" | −30 |
| No activity > 14 days | −20 |

Score range 0–100. Stored with `source`, `confidence`, `review_status`.

## What Gets Ranked
- Records sorted by health score ascending on dashboard (most at-risk first)
- Manager review queue: all records with `review_status = 'unreviewed'`

## v1 vs Later
- **v1:** keyword rules only, no external AI calls
- **Later:** LLM-generated summaries, next-step suggestions, win/loss prediction
---
name: feedback-terminal-theme-match
description: "When user asks to \"match\" themes, they mean recolor the terminal to fit existing assets - don't restyle the existing assets."
metadata:
  node_type: memory
  type: feedback
---

When the user asks for theme consistency between their terminal and another surface (GitHub README, website, etc.), default to pulling colors *from* the existing surface *into* the terminal. Do not restyle the existing surface unless explicitly told to.

**Why:** On 2026-05-27 the user asked to match Ghostty + GitHub README to a specific orange. I generated fresh orange/black SVGs for the README; they stopped me and clarified they liked the README colors as-is and just wanted the terminal to use that same scheme. The existing README is the source of truth.

**How to apply:** When the user says "make X and Y the same theme" and one of them is an existing artifact they made, ask which one is the source before generating.

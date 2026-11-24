---
name: ste
description: Explain a topic or rewrite text in ASD-STE100 Simplified Technical English, the controlled language from aerospace maintenance manuals. Defaults to "80% of the way" STE, which keeps the clarity but reads less stiffly. Use when the user says "STE", "ASD-STE100", "simplified technical English", "explain this in STE", "80% STE", or asks for an explanation that is plain, literal and hard to misread.
---

# STE

ASD-STE100 is a controlled language that aerospace companies use for maintenance documentation. Its rules make text short, literal and hard to misread. LLMs know it well. Karpathy suggested asking for explanations in it, and softening it to "80% of the way to ASD-STE100" because the full spec is very strict.

## Pick the level

- Use 80% STE by default. Follow every rule below, but use normal words when the approved STE word would sound odd, and let a descriptive sentence go a little over the limit when splitting it would hurt.
- Use strict STE when the user asks for "strict", "full" or "100%" STE. Then follow every rule exactly.
- Use the level the user names if they give a number, like "50% STE".

## Rules

Sentences

- Write procedural sentences of 20 words or fewer. Write descriptive sentences of 25 words or fewer.
- Put one instruction in each sentence. Put one idea in each descriptive sentence.
- Use the active voice. Say who or what does the action.
- Use the simple tenses. Use the present tense when you can.
- Write instructions as commands, like "Remove the cover" and not "The cover should be removed".
- Start a conditional instruction with the condition, like "If the test fails, read the log".

Words

- Use one word for one meaning, and use it the same way every time. Do not change words to sound varied.
- Use short, common words. Use "use" and not "utilize", "start" and not "commence", "help" and not "facilitate".
- Use technical names and the reader's own terms as they are. Define a term the first time you use it if the reader might not know it.
- Do not use phrasal verbs when a single verb exists. Use "remove" and not "take out".
- Do not use "-ing" words as nouns or adjectives, except in technical names.
- Keep articles like "the" and "a". Do not write in telegraph style.
- Do not use idioms, metaphors, jokes or hype.

Structure

- Keep each paragraph to one topic and 6 sentences or fewer.
- Put steps in a numbered list, one action per step, in the order the reader does them.
- Give a warning or caution before the step it applies to, not after.
- Give the main point first. Give the details after it.

## When you explain a topic

1. Say what the thing is in one or two sentences.
2. Say what it does or why it matters.
3. Explain how it works in short steps or short paragraphs.
4. Give one concrete example.
5. Do not summarize at the end. Stop when the explanation is complete.

## When you rewrite text

- Keep all the facts, steps, numbers, names and warnings. Do not summarize or drop content.
- Leave code, commands, file paths, identifiers and quotations exactly as they are.
- Return only the rewritten text unless the user asks for notes on what changed.

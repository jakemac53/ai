---
name: ai-rules-for-flutter-and-dart
description: Learn how to add AI rules to tools that accelerate your development workflow.
metadata:
  url: https://docs.flutter.dev/ai/ai-rules
  last_modified: Thu, 22 Jan 2026 01:01:25 GMT
---

# AI rules for Flutter and Dart

This guide covers how you can leverage AI rules to
streamline your Flutter and Dart development.


## Overview

[#](#overview)

AI-powered editors use rules files to provide context and
instructions to an underlying LLM. These files help you:


- Customize AI behavior to your team's needs.
- Enforce project best practices for code style and
   design.

- Provide critical project context to the AI.

The Flutter project provides several versions of the rules file to accommodate
different tool limits:


- [`rules.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md):
   The comprehensive master rule set.

- [`rules_10k.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules_10k.md):
   A condensed version (<10k chars) for tools with stricter context limits.

- [`rules_4k.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules_4k.md):
   A highly concise version (<4k chars) for limited contexts.

- [`rules_1k.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules_1k.md):
   An ultra-compact version (<1k chars) for very strict limits.


[downloadDownload the Flutter and Dart rules template](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md)

## Device & editor specific limits

[#](#device-editor-specific-limits)

Different AI coding assistants and tools have varying limits for their "rules"
or "custom instructions" files. _Last updated: 2026-01-05._

Tool / ProductRules file / FeatureLimit (soft / hard)DocumentationAntigravity (Google)`.agent/rules/<rule-name>.md`12,000 chars (Hard)[Configure rules](https://antigravity.google/docs/rules-workflows)Claude Code`CLAUDE.md`No Hard Limit[Claude Code Docs](https://code.claude.com/docs/en/memory)Cursor`AGENTS.md`No Hard Limit[Cursor Docs](https://cursor.com/docs/context/rules)Gemini CLI`GEMINI.md`1M+ Tokens (Context)[Gemini CLI Docs](https://cloud.google.com/vertex-ai/generative-ai/docs/long-context)GitHub Copilot`.github/copilot-instructions.md`~4k chars[GitHub Copilot Docs](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)JetBrains AI (Junie)`.junie/guidelines.md`No Hard Limit[JetBrains AI Docs](https://www.jetbrains.com/help/junie/get-started-with-junie.html)VS Code`.instructions.md`Unknown[Configure instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions#_use-instructionsmd-files)

infoSupport is evolving

Support for rules files is still evolving.
Please check the documentation for your specific development environment for
the most up-to-date naming conventions and instructions.


## Create rules for your editor

[#](#create-rules-for-your-editor)

You can adapt our Flutter and Dart rules template for your
specific environment. To do so, follow these steps:


1. Download the Flutter and Dart rules template:
    [`rules.md`](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md)

2. In an LLM like [Gemini](https://gemini.google.com/), attach the
    `rules.md` file that you downloaded in
    the last step.

3. Provide a prompt to reformat the file for your desired
    editor.

   Example prompt:





   ```
   Convert the attached rules.md file
   into a guidelines.md file for Gemini CLI. Make sure
   to use the styles required for a guidelines.md file.

   ```

   content\_copy

4. Review the LLM's output and make any necessary
    adjustments.

5. Follow your environment's instructions to add the new
    rules file. This may involve adding to an existing file
    or creating a new one.

6. Verify that your AI assistant is using the new rules to
    guide its responses.


Was this page's content helpful?

thumb\_upthumb\_down

Unless stated otherwise, the documentation on this site reflects Flutter 3.38.6. Page last updated on 2026-1-22. [View source](https://github.com/flutter/website/blob/main/src/content/ai/ai-rules.md) or [report an issue](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&page-url=https://docs.flutter.dev/ai/ai-rules&page-source=https://github.com/flutter/website/blob/main/src/content/ai/ai-rules.md "Report an issue with this page").
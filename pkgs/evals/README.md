# Evals Project

This project allows you to run Genkit evals using the Dart MCP server as a tool provider.

## Prerequisites

- [Dart SDK](https://dart.dev/get-dart)
- [Genkit](https://genkit.dev)
- Google GenAI API Key (optional, for model-based evals)

## Getting Started

1.  Set your Google GenAI API key:

    ```bash
    export GOOGLE_GENAI_API_KEY=your_api_key
    ```

2.  Run the evals:
    ```bash
    dart run bin/evals.dart
    ```

## Structure

- `bin/evals.dart`: The main entry point for running evals.
- `lib/`: Place your custom evaluators and logic here.

## How it works

This project uses `genkit_mcp` to connect to the local `dart_mcp_server`. Tools from the MCP server (like `analyze_files`, `pub`, `flutter_driver`) are automatically registered in the Genkit registry and can be used by Genkit tools and evaluators.

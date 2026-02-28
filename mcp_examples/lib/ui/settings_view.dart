import 'package:nocterm/nocterm.dart';
import 'package:mcp_examples/workflow_client.dart';

class SettingsView extends StatelessComponent {
  final WorkflowClient client;

  const SettingsView({super.key, required this.client});

  @override
  Component build(BuildContext context) {
    final theme = TuiTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              color: theme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 1),
          _buildModelSettings(context),
          const SizedBox(height: 1),
          const Divider(),
          const SizedBox(height: 1),
          _buildThinkingSettings(context),
        ],
      ),
    );
  }
  Component _buildModelSettings(BuildContext context) {
    final theme = TuiTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Model Selection',
          style: TextStyle(color: theme.secondary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 1),
        Row(
          children: [
            for (final model in WorkflowClient.allowedGeminiModels) ...[
              _buildModelButton(context, model),
              const SizedBox(width: 1),
            ],
          ],
        ),
      ],
    );
  }

  Component _buildModelButton(BuildContext context, String model) {
    final theme = TuiTheme.of(context);
    final shortName = model.split('-').skip(1).join('-');
    final fullModel = 'models/$model';
    final isSelected = client.modelName.value == fullModel;

    return GestureDetector(
      onTap: () {
        client.modelName.value = fullModel;
      },
      child: Container(
        decoration: BoxDecoration(
          border: BoxBorder.all(color: isSelected ? theme.primary : theme.outline),
          color: isSelected ? theme.primary : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Text(
          shortName.isEmpty ? model : shortName,
          style: TextStyle(
            color: isSelected ? theme.onPrimary : theme.onSurface,
          ),
        ),
      ),
    );
  }


  Component _buildThinkingSettings(BuildContext context) {
    final theme = TuiTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gemini Thinking Mode',
          style: TextStyle(color: theme.secondary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 1),
        Row(
          children: [
            const Text('Enabled: '),
            GestureDetector(
              onTap: () {
                client.thinkingEnabled.value = !client.thinkingEnabled.value;
              },
              child: Container(
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: theme.outline),
                  color: client.thinkingEnabled.value ? theme.primary : null,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  client.thinkingEnabled.value ? ' ON ' : ' OFF ',
                  style: TextStyle(
                    color: client.thinkingEnabled.value ? theme.onPrimary : theme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 1),
        Row(
          children: [
            const Text('Token Budget: '),
            _buildBudgetButton(context, 1024),
            const SizedBox(width: 1),
            _buildBudgetButton(context, 2048),
            const SizedBox(width: 1),
            _buildBudgetButton(context, 4096),
            const SizedBox(width: 1),
            _buildBudgetButton(context, 8192),
          ],
        ),
        const SizedBox(height: 1),
        Text(
          'Higher budget allows for deeper reasoning but uses more tokens.',
          style: TextStyle(color: theme.outline, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Component _buildBudgetButton(BuildContext context, int budget) {
    final theme = TuiTheme.of(context);
    final isSelected = client.thinkingBudget.value == budget;
    return GestureDetector(
      onTap: () {
        client.thinkingBudget.value = budget;
      },
      child: Container(
        decoration: BoxDecoration(
          border: BoxBorder.all(color: isSelected ? theme.primary : theme.outline),
          color: isSelected ? theme.primary : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Text(
          '$budget',
          style: TextStyle(
            color: isSelected ? theme.onPrimary : theme.onSurface,
          ),
        ),
      ),
    );
  }
}

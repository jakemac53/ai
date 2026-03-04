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
            style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold),
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
          border: BoxBorder.all(
            color: isSelected ? theme.primary : theme.outline,
          ),
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
          'Show Thoughts',
          style: TextStyle(color: theme.secondary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 1),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                client.showThoughts.value = !client.showThoughts.value;
              },
              child: Container(
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: theme.outline),
                  color: client.showThoughts.value ? theme.primary : null,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  client.showThoughts.value ? ' ON ' : ' OFF ',
                  style: TextStyle(
                    color:
                        client.showThoughts.value
                            ? theme.onPrimary
                            : theme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

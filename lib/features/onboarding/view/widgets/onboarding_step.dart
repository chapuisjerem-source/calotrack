import 'package:flutter/material.dart';

class OnboardingStep extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const OnboardingStep({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
          const SizedBox(height: 24),
          Expanded(child: child),
        ],
      ),
    );
  }
}

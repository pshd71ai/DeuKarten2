import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../models/chat_message_model.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatMessageModel message;
  final bool isUser;

  const ChatBubbleWidget({
    required this.message,
    required this.isUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor = isUser ? AppColors.primary : AppColors.surface;
    final textColor = isUser ? Colors.white : AppColors.textPrimary;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.type == ChatMessageType.grammar)
              _buildGrammarBubble(context)
            else if (message.type == ChatMessageType.correction)
              _buildCorrectionBubble(context)
            else if (message.type == ChatMessageType.suggestions)
              _buildSuggestionsBubble(context)
            else
              _buildTextBubble(context, backgroundColor, textColor),

            // Timestamp
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextBubble(BuildContext context, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              message.content,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
          if (!isUser)
            _buildCopyButton(),
        ],
      ),
    );
  }

  Widget _buildGrammarBubble(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.menu_book, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Grammatik-Erklärung',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Content
          Text(
            message.content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorrectionBubble(BuildContext context) {
    final parts = message.content.split('|');
    final before = parts.length > 0 ? parts[0] : '';
    final after = parts.length > 1 ? parts[1] : '';

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.spellcheck, size: 18, color: AppColors.warning),
              const SizedBox(width: 8),
              Text(
                'Korrektur',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Before
          if (before.isNotEmpty) ...[
            Text(
              'Vorher:',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                before,
                style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.error,
                ),
              ),
            ),
          ],

          // After
          if (after.isNotEmpty) ...[
            Text(
              'Korrektur:',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                after,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSuggestionsBubble(BuildContext context) {
    final suggestions = message.content.split('\n').where((s) => s.isNotEmpty).toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 18, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                'Vorschläge',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestions.map((suggestion) {
              return InkWell(
                onTap: () {
                  // TODO: Use suggestion
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                  ),
                  child: Text(
                    suggestion.trim(),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyButton() {
    return IconButton(
      icon: Icon(Icons.copy, size: 16, color: AppColors.textSecondary),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: message.content));
      },
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

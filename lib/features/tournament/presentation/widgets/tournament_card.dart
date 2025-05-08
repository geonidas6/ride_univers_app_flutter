import 'package:flutter/material.dart';
import '../../domain/entities/tournament.dart';

class TournamentCard extends StatelessWidget {
  final Tournament tournament;
  final VoidCallback? onJoin;
  final VoidCallback? onLeave;
  final VoidCallback onTap;

  const TournamentCard({
    super.key,
    required this.tournament,
    this.onJoin,
    this.onLeave,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isUpcoming = tournament.date.isAfter(now);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(context),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(),
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getStatusText(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tournament.title ?? 'Sans titre',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (tournament.description != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      tournament.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(tournament.date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people_outline, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${tournament.participantIds.length} participants',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (onJoin != null || onLeave != null)
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onJoin != null)
                      TextButton.icon(
                        onPressed: onJoin,
                        icon: const Icon(Icons.add),
                        label: const Text('Rejoindre'),
                      )
                    else if (onLeave != null)
                      TextButton.icon(
                        onPressed: onLeave,
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('Quitter'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                      ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    switch (tournament.status) {
      case 'draft':
        return Colors.grey;
      case 'active':
        return Theme.of(context).primaryColor;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (tournament.status) {
      case 'draft':
        return Icons.edit_outlined;
      case 'active':
        return Icons.sports_score;
      case 'completed':
        return Icons.emoji_events_outlined;
      case 'cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusText() {
    switch (tournament.status) {
      case 'draft':
        return 'À venir';
      case 'active':
        return 'En cours';
      case 'completed':
        return 'Terminé';
      case 'cancelled':
        return 'Annulé';
      default:
        return 'Inconnu';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

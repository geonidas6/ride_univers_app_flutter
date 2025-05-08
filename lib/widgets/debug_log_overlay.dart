import 'package:flutter/material.dart';
import '../services/logger_service.dart';
import '../core/enums/log_level.dart';

class DebugLogOverlay extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const DebugLogOverlay({
    super.key,
    required this.child,
    this.enabled = true,
  });

  @override
  State<DebugLogOverlay> createState() => _DebugLogOverlayState();
}

class _DebugLogOverlayState extends State<DebugLogOverlay> {
  final List<String> _logs = [];
  bool _isVisible = false;

  void _handleLog(
    String message, {
    LogLevel level = LogLevel.info,
    Object? error,
    StackTrace? stackTrace,
  }) {
    setState(() {
      _logs.add('${level.name.toUpperCase()}: $message');
      if (error != null) {
        _logs.add('ERROR: $error');
      }
      if (stackTrace != null) {
        _logs.add('STACK: $stackTrace');
      }
      // Garder seulement les 100 derniers logs
      if (_logs.length > 100) {
        _logs.removeAt(0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      LoggerService.addCallback(_handleLog);
    }
  }

  @override
  void dispose() {
    if (widget.enabled) {
      LoggerService.removeCallback(_handleLog);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return Stack(
      children: [
        widget.child,
        if (_isVisible)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              color: Colors.black.withOpacity(0.8),
              child: ListView.builder(
                reverse: true,
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[_logs.length - 1 - index];
                  Color color;
                  if (log.startsWith('ERROR')) {
                    color = Colors.red;
                  } else if (log.startsWith('WARNING')) {
                    color = Colors.orange;
                  } else if (log.startsWith('DEBUG')) {
                    color = Colors.grey;
                  } else {
                    color = Colors.white;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    child: Text(
                      log,
                      style: TextStyle(color: color, fontSize: 12),
                    ),
                  );
                },
              ),
            ),
          ),
        Positioned(
          bottom: _isVisible ? 200 : 0,
          right: 0,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Icon(_isVisible ? Icons.close : Icons.bug_report),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatefulWidget {
    final VoidCallback onRefresh;
    final Widget child;

    const CustomRefreshIndicator({super.key, required this.onRefresh, required this.child});

    @override
    _CustomRefreshIndicatorState createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator> {
    bool _isRefreshing = false;

    Future<void> _handleRefresh() async {
        await Future.delayed(const Duration(seconds: 4)); // Simulating a delay
        setState(() {
            _isRefreshing = true;
        });

        widget.onRefresh();

        setState(() {
            _isRefreshing = false;
        });
    }

    @override
    Widget build(BuildContext context) {
        return RefreshIndicator(
            color: Colors.red,
            onRefresh: _handleRefresh,
            child: _isRefreshing
                ? const Center(child: CircularProgressIndicator(
                color: Colors.red,
            ))
                : widget.child,
        );
    }
}

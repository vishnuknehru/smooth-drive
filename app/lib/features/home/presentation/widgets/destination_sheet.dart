import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers.dart';
import '../../../drive/domain/entities/route_analysis.dart';
import '../../data/saved_places_repository.dart';
import '../../domain/saved_place.dart';

class DestinationSheet extends ConsumerStatefulWidget {
  const DestinationSheet({super.key, required this.onDestinationSelected});

  final void Function(Coord destination) onDestinationSelected;

  @override
  ConsumerState<DestinationSheet> createState() => _DestinationSheetState();
}

class _DestinationSheetState extends ConsumerState<DestinationSheet> {
  final _controller = TextEditingController();
  String? _parseError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Coord? _parse(String raw) {
    final parts = raw.trim().split(RegExp(r'[,\s]+'));
    if (parts.length != 2) return null;
    final lat = double.tryParse(parts[0]);
    final lon = double.tryParse(parts[1]);
    if (lat == null || lon == null) return null;
    if (lat < -90 || lat > 90 || lon < -180 || lon > 180) return null;
    return Coord(lat: lat, lon: lon);
  }

  void _submit() {
    final coord = _parse(_controller.text);
    if (coord == null) {
      setState(() => _parseError = 'Enter a valid "lat, lon" pair');
      return;
    }
    Navigator.pop(context);
    widget.onDestinationSelected(coord);
  }

  Future<void> _saveCurrentLocation() async {
    // Gets a quick GPS fix to capture current position as a saved place.
    // Uses clock as a unique name; name edit is a post-MVP feature.
    final now = ref.read(clockProvider)();
    final label =
        'Location ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    // We don't block the sheet on a real GPS call — user can paste coords
    // and save the name as a place manually in a future sprint. For now we
    // save the pasted or typed coord (if valid) as a named place.
    final coord = _parse(_controller.text);
    if (coord == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter lat, lon first to save as a place'),
        ),
      );
      return;
    }
    await ref
        .read(savedPlacesRepositoryProvider)
        .add(SavedPlace(name: label, coord: coord));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved as "$label"')),
      );
      setState(() {}); // refresh saved places list
    }
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.read(savedPlacesRepositoryProvider).getAll();
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: scheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Text(
            'Where are you going?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // Manual lat/lon entry
          TextField(
            controller: _controller,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(
              labelText: 'Lat, Lon',
              hintText: '51.5074, -0.1278',
              errorText: _parseError,
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward),
                tooltip: 'Go',
                onPressed: _submit,
              ),
            ),
            onChanged: (_) => setState(() => _parseError = null),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 8),

          // Save current location button
          TextButton.icon(
            icon: const Icon(Icons.bookmark_add_outlined),
            label: const Text('Save this location'),
            onPressed: _saveCurrentLocation,
          ),

          if (places.isNotEmpty) ...[
            const Divider(height: 24),
            Text(
              'Saved places',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 4),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: places.length,
                itemBuilder: (context, i) {
                  final place = places[i];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.place_outlined),
                    title: Text(place.name),
                    subtitle: Text(
                      '${place.coord.lat.toStringAsFixed(4)}, '
                      '${place.coord.lon.toStringAsFixed(4)}',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      widget.onDestinationSelected(place.coord);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'Remove',
                      onPressed: () async {
                        await ref
                            .read(savedPlacesRepositoryProvider)
                            .remove(place.name);
                        if (mounted) setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

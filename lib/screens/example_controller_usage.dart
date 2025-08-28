import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/di/providers.dart';

class ExampleControllerUsageScreen extends ConsumerWidget {
  const ExampleControllerUsageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the controllers for automatic UI updates
    final userProfile = ref.watch(userProfileControllerProvider);
    final teams = ref.watch(teamControllerProvider);
    final games = ref.watch(gameFeedControllerProvider);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Controller Usage Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh all data
              ref.read(userProfileControllerProvider.notifier).refresh();
              ref.read(teamControllerProvider.notifier).refresh();
              ref.read(gameFeedControllerProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Authentication Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Authentication Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('Is Authenticated: ${isAuthenticated ? "Yes" : "No"}'),
                    if (isAuthenticated)
                      ElevatedButton(
                        onPressed: () {
                          ref.read(authControllerProvider.notifier).signOut();
                        },
                        child: const Text('Sign Out'),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User Profile Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    userProfile.when(
                      data: (profile) => profile != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${profile.displayName ?? "Not set"}'),
                                Text('City: ${profile.city ?? "Not set"}'),
                                Text('Teams: ${profile.teams.length}'),
                                Text('Sports: ${profile.sports.length}'),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(userProfileControllerProvider.notifier)
                                        .updateLocation('New York');
                                  },
                                  child: const Text('Update Location to NY'),
                                ),
                              ],
                            )
                          : const Text('No profile data'),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Teams Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teams',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    teams.when(
                      data: (teamsList) => teamsList.isNotEmpty
                          ? Column(
                              children: teamsList.map((team) => ListTile(
                                title: Text(team.name),
                                subtitle: Text('${team.sport} - ${team.city}'),
                                trailing: Text('${team.currentMemberCount}/${team.maxMembers} members'),
                              )).toList(),
                            )
                          : const Text('No teams found'),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(teamControllerProvider.notifier).createTeam({
                          'name': 'New Team ${DateTime.now().millisecondsSinceEpoch}',
                          'sport': 'Basketball',
                          'city': 'Local City',
                          'skillLevel': 'Beginner',
                          'description': 'A sample team for testing',
                          'maxMembers': 15,
                          'createdBy': 'current-user-id',
                        });
                      },
                      child: const Text('Create Sample Team'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Games Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Games',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    games.when(
                      data: (gamesList) => gamesList.isNotEmpty
                          ? Column(
                              children: gamesList.map((game) => ListTile(
                                title: Text(game.title),
                                subtitle: Text('${game.sport} - ${game.location}'),
                                trailing: Text('${game.participants.length}/${game.maxPlayers}'),
                              )).toList(),
                            )
                          : const Text('No games found'),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(gameFeedControllerProvider.notifier).searchGames(
                          query: 'basketball',
                          sport: 'Basketball',
                        );
                      },
                      child: const Text('Search Basketball Games'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

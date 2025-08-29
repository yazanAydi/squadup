# Architecture Layout (enforced)

- `lib/presentation/` — UI (widgets/screens), routing, theme, Riverpod providers.
- `lib/domain/` — entities (Freezed), value objects, repositories (interfaces), usecases.
- `lib/data/` — Firebase/HTTP implementations, mappers, local caches.

Rules:
- Presentation depends on Domain (usecases/providers), never on Data.
- Data depends on Domain for interfaces; implements them under `lib/data/repositories/`.
- No Firebase types in Domain; map to/from Domain models in Data.
- Theme + localization live under `lib/presentation/theme/` and `lib/presentation/l10n/`.

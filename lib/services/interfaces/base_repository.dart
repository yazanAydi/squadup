/// Base repository interface for all data repositories
abstract class BaseRepository<T> {
  /// Get all items
  Future<List<T>> getAll();
  
  /// Get item by ID
  Future<T?> getById(String id);
  
  /// Create new item
  Future<String> create(T item);
  
  /// Update existing item
  Future<void> update(String id, T item);
  
  /// Delete item by ID
  Future<void> delete(String id);
  
  /// Check if item exists
  Future<bool> exists(String id);
}

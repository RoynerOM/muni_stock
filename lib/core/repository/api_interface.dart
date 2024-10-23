abstract class IApi<T> {
  Future<List<T>> getAll(); // Obtener todos los objetos de tipo T
  Future<T?> getById(int id); // Obtener un objeto por su ID
  Future<void> post(T item); // Añadir un objeto nuevo
  Future<void> update(T item); // Actualizar un objeto existente
  Future<void> delete(int id); // Eliminar un objeto por su ID
}

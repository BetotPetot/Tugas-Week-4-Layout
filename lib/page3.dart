
import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final List<String> todoLists = [];

  String? selectedList;

  // Menambahkan To-Do List baru
  Future<void> addTodoList() async {
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('New To-Do List'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Nama To-Do List',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  controller.text.trim(),
                );
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );

    if (!mounted || name == null || name.isEmpty) {
      return;
    }

    if (todoLists.contains(name)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama daftar sudah digunakan!'),
        ),
      );
      return;
    }

    setState(() {
      todoLists.add(name);
      selectedList = name;
    });
  }

  //Menghapus To-Do List yang sudah selesai
  void completeTodoList(int index) {
    setState(() {
      final removedList = todoLists[index];

      todoLists.removeAt(index);

      // Jika daftar yang dihapus sedang dipilih,
      // pilih daftar lain atau kosongkan pilihan.
      if (selectedList == removedList) {
        selectedList =
            todoLists.isEmpty ? null : todoLists.first;
      }
    });
  }

  // Menghapus daftar yang dipilih
  void deleteTodoList() {
    if (selectedList == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih daftar yang ingin dihapus!'),
        ),
      );
      return;
    }

    setState(() {
      final index = todoLists.indexOf(selectedList!);
      todoLists.removeAt(index);

      selectedList = todoLists.isEmpty
          ? null
          : todoLists.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul halaman
          const Text(
            'To-Do List',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Divider(thickness: 2),

          const SizedBox(height: 16),

          // Tombol tambah dan hapus
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: addTodoList,
                  icon: const Icon(Icons.add),
                  label: const Text('New To-Do List'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filled(
                onPressed: deleteTodoList,
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Hapus daftar',
              ),
            ],
          ),

          const Divider(thickness: 2),

          const SizedBox(height: 8),

          // Daftar To-Do List
          Expanded(
            child: todoLists.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada To-Do List.\n'
                      'Tekan + untuk membuat daftar baru.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: todoLists.length,
                    itemBuilder: (context, index) {
                      final name = todoLists[index];
                      final isSelected = name == selectedList;

                      return Card(
                        color: isSelected
                            ? Colors.deepPurple.shade100
                            : null,
                        child: ListTile(
                          leading: const Icon(
                            Icons.checklist,
                          ),

                          title: Text(name),

                          // Tombol ceklis selalu terlihat
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.deepPurple,
                            ),
                            tooltip: 'Selesaikan daftar',
                            onPressed: () {
                              completeTodoList(index);
                            },
                          ),

                          // Tekan bagian daftar untuk memilihnya
                          onTap: () {
                            setState(() {
                              selectedList = name;
                            });
                          },
                        ),
                      );
                    },
                  )
          ),

          // Informasi daftar terpilih
          if (selectedList != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Dipilih: $selectedList',
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

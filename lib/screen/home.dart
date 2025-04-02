import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/theme/style.dart';
import 'package:todo/viewmodel/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final catatanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    // Pisahkan list todo menjadi on progress dan completed
    final onProgressTodos =
        todoProvider.todos.where((todo) => !todo.isDone).toList();
    final completedTodos =
        todoProvider.todos.where((todo) => todo.isDone).toList();

    return Scaffold(
      // Hilangkan background default, ganti dengan gradient yang lembut
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFCE8F8), // Pastel pink
              Color(0xFFE7E2F3), // Pastel purple
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  // Anda bisa mengganti asset image ini sesuai keinginan
                  image: const DecorationImage(
                    image: AssetImage('assets/header.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Todo List',
                    style: whiteTextStyle.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Bagian konten utama
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section On Progress
                        Text(
                          'On Progress',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            // Ubah warna teks sedikit lebih gelap ke ungu tua
                            color: const Color(0xFF5C3D6B),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child:
                              onProgressTodos.isNotEmpty
                                  ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: onProgressTodos.length,
                                    itemBuilder: (BuildContext context, index) {
                                      final todo = onProgressTodos[index];
                                      return Card(
                                        elevation: 2,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 4,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: ListTile(
                                          // Gunakan ungu tua atau cokelat tua untuk avatar
                                          leading: CircleAvatar(
                                            backgroundColor: const Color(
                                              0xFF6B4F7C,
                                            ),
                                            child: Text(
                                              todo.id,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            todo.isi,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  todo.isDone
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                              // Ubah warna jadi lebih gelap
                                              color: const Color(0xFF4E3A59),
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Status: ${todo.isDone ? 'Selesai' : 'Belum Selesai'}",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              todo.isDone
                                                  ? Icons.check_box
                                                  : Icons
                                                      .check_box_outline_blank,
                                              color: const Color(0xFF6B4F7C),
                                            ),
                                            onPressed: () {
                                              todoProvider.toggleTodoStatus(
                                                todo.id,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  : Center(
                                    child: Text(
                                      "Tidak ada task On Progress",
                                      style: blackTextStyle.copyWith(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                        ),
                        const SizedBox(height: 20),

                        // Section Completed
                        Text(
                          'Completed',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: const Color(0xFF5C3D6B),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child:
                              completedTodos.isNotEmpty
                                  ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: completedTodos.length,
                                    itemBuilder: (BuildContext context, index) {
                                      final todo = completedTodos[index];
                                      return Card(
                                        elevation: 2,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 4,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: const Color(
                                              0xFF6B4F7C,
                                            ),
                                            child: Text(
                                              todo.id,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            todo.isi,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Color(0xFF4E3A59),
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Status: Selesai",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(
                                              Icons.check_box,
                                              color: Color(0xFF6B4F7C),
                                            ),
                                            onPressed: () {
                                              todoProvider.toggleTodoStatus(
                                                todo.id,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  : Center(
                                    child: Text(
                                      "Tidak ada task Completed",
                                      style: blackTextStyle.copyWith(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Inputan catatan di bagian bawah
              Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B4F7C), // Ungu tua
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: catatanController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Masukkan catatan...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        String inputText = catatanController.text;
                        if (inputText.isNotEmpty) {
                          todoProvider.tambahTodo(inputText);
                          catatanController.clear();
                        }
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

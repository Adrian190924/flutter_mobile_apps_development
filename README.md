# Mobile Apps Developtment Subject
Project ini adalah aplikasi "Expense Tracker" (Pelacak Pengeluaran) minimalis yang dibangun menggunakan Flutter.
Aplikasi ini memungkinkan pengguna untuk mengelola pengeluaran harian mereka melalui UI yang simpel.
Saat ini dalam proses mendemonstrasikan pola MVVM.

## MVVM Architecture Overview
Penggunaan desain MVVM Pattern memastikan pemisahan yang jelas antara U, logika, dan data.

### 1. Model (Data Layer)
* **File:** 'lib/model/expense.dart'
* **Repository:** ('lib/data/repository/expense_repository.dart')
* Mewakili struktur data dari satu entitas pengeluaran. Berisikan atribut seperti 'id', 'title', 'amount', 'date' dan 'category'
* Repositorynya mensimulasikan sumber data. Menangani operasi **CRUD** (Create, Read, Update, Delete)

  ## 2. View (UI Layer)
  * **Files:** 'lib/view/pages/home_page.dart' dan 'lib/view/pages/add_expense_page.dart'
  * UI yang berinteraksi dengan user, memiliki dua halaman. Viewnya mengamati perubahan dalam ViewModel menggunakan widget 'Consumer' dari package 'provider' dan membangun ulang secara otomatis ketika data berubah.
  * **Home Page:** Menampilkan daftar pengeluaran dan memiliki fitur gesture "Swipe to delete"
  * **Add Expense Page:** Form untuk membuat pengeluaran baru atau mengedit data pengeluaran yang sudah ada.
    
### 3. View Model (Logic Layer)
* **File:** 'lib/view_model/expense_view_model.dart'
* Bertindak sebagai penghubung antara View dan Modelnya. Menyimpan application state. Extend 'ChangeNotifier' untuk memberi tahu UI setiap kali state berubah. Berisikan logika untuk fetch,add,update, dan delete data.

## Cara Menjalankan Aplikasi
Ketika aplikasi pertama kali dijalankan, tidak ada data yang ditampilkan. Berikut adalah cara untuk menambah, mengubah, dan menghapus data pengeluaran

### Add
* Gunakan tombol "+" Di kanan bawah layar untuk menambahkan data. Tampilan akan berubah menjadi form yang berisikan judul/title, Amount (Rp), dan Category. Silahkan Diisi sesuai kebutuhan. Akan terjadi error jika memasukkan huruf di bagian Amount (Rp). Klik "Save Expense" untuk menyimpan data. Secara otomatis akan kembali ke home page dan data yang dimasukkan akan ditampilkan

### Edit
* Untuk mengedit data, klik data yang sudah ada. Tampilan akan berubah ke bentuk formulir sama seperti saat menambah data, bedanya semua form sudah terisi. Pengguna bisa mengubah data yang sudah ada dengan bebas. Jika sudah selesai tinggal klik "Update Changes" untuk menyimpan dan kembali ke home page.

### Delete
* Untuk menghapus data, user hanya perlu menggeser data yang ada di list ke kiri. Secara otomatis data akan terhapus.

## Reflection
* Sebenarnya banyak sekali hal yang belum saya pahami mengenai berbagai jenis fitur dari flutter. Saya juga belum terbiasa untuk coding menggunakan Flutter ini. Dengan mengerjakan AFL 2 ini saya jadi bisa mempelajari bahwa Flutter ini sangat fleksibel. Banyak sekali widgets yang bisa dipakai, terlalu banyak sampai saya kadang bingung dengan penggunaannya. Jujur saya sering bertanya kepada AI untuk mempelajari berbagai macam kode, fungsi, widgets, dan lain-lain. Menyambungkan Repisotory ini ke Google Gemini AI untuk mengerjakan sekaligus belajar tentang Flutter. Fitur “Guided Learning” dari gemini juga kadang bertanya balik kepada saya tentang kode itu sendiri, menjelaskan dengan detil mengenai MVVM, dan bagaimana caranya untuk mengimplementasikannya ke dalam program “Expense Tracker” yang saya buat ini.

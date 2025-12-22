# uco_mad_sem4 (Mobile Apps Development - Progress AFL 3)

## 🧪 Unit Testing

Implementasi Unit Testing untuk class `ExpenseViewModel` untuk memastikan integritas logikanya.

**Test File:** `test/expense_view_model_test.dart`

**Function yang di testing:**
1.  **`addExpense()`**: Memverifikasi pengeluaran baru dibuat dan ditambahkan dengan benar ke state list.
2.  **`updateExpense()`**: Test untuk memastikan bahwa pengeditan data pengeluaran seperti judul, harga, dan/atau kategori benar-benar memperbarui objek yang ada tanpa menduplikasinya.
3.  **`deleteExpense()`**: Memverifikasi bahwa suatu item benar-benar dihapus dari daftar dan perhitungan total pengeluaran diperbarui secara langsung.
4.  **Budget Logic (`budgetProgress`)**: Test uji logika matematika untuk memastikan Progress Bar menerima data secara benar dan mendeteksi over-budget.

**Logic Followed (Arrange-Act-Assert):**
* **Arrange:** Inisialisasi ViewModel dan mendefinisikan data dummy.
* **Act:** Memanggil method asynchronous (`addExpense`, `deleteExpense`).
* **Assert:** Mengecek apakah pengujian sesuai dengan nilai yang diharapkan menggunakan `expect()`.

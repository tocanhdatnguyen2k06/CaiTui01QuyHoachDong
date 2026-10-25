# 🎯 0/1 Knapsack DP Visualizer App (DT051)

> **Đồ án môn học Cấu trúc Dữ liệu và Giải thuật (INT13185)**  
> **Học viện Công nghệ Bưu chính Viễn thông (PTIT) — Cơ sở tại TP. Hồ Chí Minh**  
> *Được thiết kế và mở rộng thành ứng dụng Web trực quan hóa thuật toán Quy hoạch động (Algorithm Visualizer) chuẩn production.*

---

## 📑 THÔNG TIN ĐỒ ÁN & HƯỚNG DẪN ĐỐI CHIẾU (Theo Rubric)

### 1. Nhận diện
- **Họ và tên:** Tô Cảnh Đạt Nguyên  
- **MSSV:** N24DCDT057  
- **Lớp:** D24CQDT01-N  
- **Mã đề tài:** **DT051**  
- **Tên đề tài:** **Cái túi 0/1 bằng bảng quy hoạch động**  
- **Đường dẫn phiếu:** `Danh_sach_va_de_giao/91_Phieu_giao_de_tai_INT13185_N03.docx` (Mục DT051)  
- **Căn cứ giáo trình:** *Giáo trình Cấu trúc dữ liệu và Giải thuật (INT1306)*, Chương 4, mục **4.3.2.2 Bài toán cái túi**; Ví dụ 4.8; Bài 4.3; Bài tập chương 4, câu 22 và 32; trang in 98–100, 103, 112; trang PDF 110–112, 115, 124.

### 2. Môi trường
- **Ngôn ngữ:** Python 3.11  
- **Thư viện sử dụng:** `Flask==3.0.0` (Web Server), `pytest==7.4.0` (Kiểm thử), `gunicorn==21.2.0` (Triển khai).  
- **Nguyên tắc kỹ thuật:** Thuật toán lõi quy hoạch động và truy vết tự cài đặt hoàn toàn 100%, không sử dụng thư viện giải thuật có sẵn.  
- **Lệnh cài đặt:**  
  ```bash
  pip install -r requirements.txt
  ```

### 3. Lệnh thực thi nhanh
- **Chạy Ví dụ 1 (Ví dụ 4.8 giáo trình — n=4, W=10):**  
  ```bash
  python -c "from logic import giai_cai_tui_dp; print(giai_cai_tui_dp([5, 4, 6, 3], [10, 40, 30, 50], 10))"
  ```
- **Chạy Ví dụ 2 (Ca biên — n=1, W=4, w=[2], v=[3]):**  
  ```bash
  python -c "from logic import giai_cai_tui_dp; print(giai_cai_tui_dp([2], [3], 4))"
  ```
- **Lệnh chạy giao diện Web trực quan:**  
  ```bash
  python app.py
  ```
  *(Truy cập `http://localhost:5000` để nhập số lượng đồ vật, sức chứa W, trọng lượng và giá trị tùy ý).*
- **Lệnh chạy toàn bộ kiểm thử tự động:**  
  ```bash
  pytest test_logic.py -v
  ```

### 4. Quy ước dữ liệu & Kiểm soát lỗi
- **Input:** Số nguyên $n \ge 1$, sức chứa túi $W \ge 0$, hai mảng số nguyên dương trọng lượng $w = [w_1, \dots, w_n]$ và giá trị $v = [v_1, \dots, v_n]$ ($w_i > 0, v_i > 0$). Giới hạn mặc định theo phiếu $n \le 100, W \le 1000$ (hệ thống mở rộng linh hoạt tùy chế độ).
- **Thứ tự chỉ số:** Thuật toán lõi lưu bảng ma trận $f$ kích thước $(n+1) \times (W+1)$ với chỉ số 1-based đồng bộ với công thức toán và mã giả giáo trình.
- **Output:** Trả về bộ giá trị gồm: Giá trị lớn nhất đạt được $f[n][W]$, danh sách đồ vật được chọn `[ID_1, ID_2, ...]` (đã sắp xếp tăng dần), tổng trọng lượng thực tế và toàn bộ bảng ma trận trạng thái phục vụ hiển thị/truy vết.
- **Xử lý lỗi (Validator):** Nếu nhập $W < 0$, $n \le 0$, số lượng phần tử của $w$ và $v$ không khớp nhau, hoặc tồn tại $w_i \le 0$, $v_i \le 0$, Validator sẽ chặn luồng thực thi và thông báo lỗi rõ ràng trên giao diện (mã HTTP 400).

### 5. Minh chứng & Phiên bản Git
- **Thư mục ảnh minh chứng:** `docs/anh_ket_qua/` (Chứa đủ 11 ảnh minh chứng từ A01 đến A11 theo quy định).
- **Mã ca kiểm thử:** Bảng 4.1 (12 ca chức năng), Bảng 4.2 (16 ca validator/biên) chi tiết trong báo cáo `BaoCao.docx`.
- **SHA chạy C (Commit tạo kết quả):** `[Điền mã SHA C đầy đủ của bạn vào đây]`
- **SHA nộp S (Commit hoàn thiện báo cáo/ảnh):** Ghi chú chi tiết trong tệp `ThongTinNop.txt` nộp kèm trên Classroom.

---

## 📖 Giới thiệu

Ứng dụng web trực quan hóa bài toán **Cái túi 0/1 bằng bảng Quy hoạch động (0/1 Knapsack DP Visualizer)** được xây dựng nhằm mục đích biến các công thức truy hồi trừu tượng thành bảng ma trận trực quan, sống động.

Thay vì chỉ in ra đáp số cuối cùng, ứng dụng mô phỏng chi tiết từng bước tính toán tại từng ô $f[i, j]$, làm nổi bật sự so sánh giữa hai nhánh quyết định: **"Không lấy đồ vật $i$"** ($f[i-1, j]$) và **"Lấy đồ vật $i$"** ($f[i-1, j - w_i] + v_i$). Đặc biệt, ứng dụng minh họa trực quan quá trình **Truy vết ngược (Traceback)** từ ô đích $f[n, W]$ về ô gốc $f[0, 0]$ bằng đường phát sáng (glow path) để người học hiểu rõ vì sao một đồ vật được chọn hay bị loại bỏ.

---

## 🚀 Tính năng nổi bật

### 1. Tối ưu hóa thuật toán lõi
- **Bảng Quy hoạch động 2D đầy đủ:** Kích thước $(n+1) \times (W+1)$ phục vụ lưu vết và truy xuất nghiệm tối ưu với độ phức tạp thời gian và không gian $O(n \cdot W)$.
- **Bản tối ưu bộ nhớ 1D ($O(W)$ không gian):** Hỗ trợ tính nhanh giá trị cực đại với mảng 1 chiều, duyệt ngược $j$ từ $W$ về $w_i$ để đảm bảo mỗi đồ vật chỉ được chọn tối đa một lần (đúng chuẩn bất biến đề tài DT051).
- **Bộ đối chiếu độc lập (Brute Force Oracle):** Đối chiếu song song với thuật toán duyệt nhánh vét cạn trên các tập dữ liệu nhỏ ($n \le 15$) để tự động chứng minh nghiệm tìm được là tối ưu tuyệt đối.

### 2. Trực quan hóa ma trận DP (Interactive Visualizer)
- **Mô phỏng từng ô ma trận:** Tô màu trực quan 3 ô liên quan tại mỗi bước:
  - Ô đang tính: $f[i, j]$ (Màu vàng/cam)
  - Ô phương án bỏ qua: $f[i-1, j]$ (Màu xanh dương)
  - Ô phương án chọn kèm: $f[i-1, j - w_i]$ (Màu tím)
- **Truy vết động (Animated Traceback):** Vẽ đường viền phát sáng qua các ô dẫn đến nghiệm tối ưu, hiển thị mũi tên quyết định `CHỌN` (khi $f[i, j] \ne f[i-1, j]$) hoặc `BỎ` (khi $f[i, j] == f[i-1, j]$).
- **Bộ điều khiển linh hoạt:** Bước trước / Bước tiếp / Tự động chạy (Play/Pause) / Chạy tới ô đích / Đặt lại (Reset) với tốc độ điều chỉnh mượt mà từ 50ms đến 1500ms.

### 3. Xuất dữ liệu ma trận & Báo cáo (Export Feature)
- Hỗ trợ xuất toàn bộ bảng ma trận quy hoạch động $f[i, j]$ kèm danh sách đồ vật đã chọn ra file `.csv`.
- Tích hợp chuẩn **BOM UTF-8**, đảm bảo mở trực tiếp trên Microsoft Excel không bị lỗi phông tiếng Việt hay xô lệch cột.
- Cơ chế bảo vệ tràn bộ nhớ (Memory Guard Modal): Tự động cảnh báo và chặn tải nếu bảng ma trận vượt quá kích thước an toàn ($n \cdot W > 1.000.000$ ô).

### 4. Gia sư ảo — Quiz Động (Dynamic DP Quiz)
- Tự động dừng tại một bước ngẫu nhiên trên bảng ma trận để sinh câu hỏi trắc nghiệm kiểm tra kiến thức:
  - *Tại sao ô $f[i, j]$ lại nhận giá trị X?*
  - *Đồ vật thứ $i$ có được đưa vào túi ở trạng thái này không?*
  - *Tại sao vòng lặp 1 chiều của bài toán Cái túi 0/1 bắt buộc phải duyệt $j$ giảm dần?*
- Đánh giá tức thì: Tô xanh đáp án đúng, tô đỏ đáp án sai kèm lời giải thích chi tiết bám sát giáo trình.

### 5. Kiểm thử tính đúng đắn & Ca biên (Validation Test Suite)
- Tích hợp sẵn bộ test kiểm thử tự động 12 ca chức năng + 16 ca biên:
  - Ca túi rỗng: $W = 0 \rightarrow$ giá trị 0, tập chọn `[]`.
  - Ca mọi vật quá nặng: $w_i > W \rightarrow$ không chọn được vật nào.
  - Ca mẫu giáo trình: Ví dụ 4.8 chuẩn kết quả giá trị 90, chọn `[2, 4]`.
  - Ca kiểm tra bất biến: Xác nhận mọi nghiệm có tổng trọng lượng $\le W$ và mỗi ID xuất hiện tối đa một lần.

### 6. Giao diện & Trải nghiệm người dùng (UI/UX)
- Bố cục 3 khối chuẩn công thái học: **Bảng điều khiển & Nhập liệu** — **Ma trận trực quan** — **Bảng phân tích & Traceback log**.
- Hỗ trợ đầy đủ **Dark Mode / Light Mode** mượt mà, lưu trạng thái vào `localStorage` chống giật nháy màu (FOUC).
- Bảng ma trận tự động tính toán kích thước ô (auto-scroll) chống tràn layout khi $W$ lớn.

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Công nghệ |
| :--- | :--- |
| **Backend** | Python 3.11, Flask 3.0.0, Gunicorn |
| **Frontend** | HTML5, CSS3 (CSS Variables, Flexbox/Grid), JavaScript ES6+ thuần |
| **Testing** | Pytest 7.4.0 |
| **DevOps & CI/CD** | Docker, GitHub Actions, Render Cloud |
| **Giải thuật** | Dynamic Programming (2D & 1D array), Backtracking Traceback, Exhaustive Search Oracle |

---

## 📂 Cấu trúc thư mục

```text
cai_tui_dp_app/
├── .github/
│   └── workflows/
│       └── ci.yml             # Cấu hình GitHub Actions CI/CD tự động test
├── static/
│   ├── css/
│   │   └── style.css          # CSS giao diện, Dark/Light mode, hiệu ứng bảng DP
│   └── js/
│       └── visualizer.js      # Script mô phỏng bước chạy và truy vết
├── templates/
│   └── index.html             # Giao diện chính (Dashboard + Visualizer + Quiz)
├── docs/
│   └── anh_ket_qua/           # Thư mục lưu trữ 11 ảnh minh chứng thực chạy A01–A11
├── tests/
│   └── test_logic.py          # Kiểm thử tự động với Pytest (>= 28 ca test)
├── app.py                     # Flask Server, API routes, streaming CSV
├── logic.py                   # Thuật toán DP lõi, truy vết ngược, validation
├── requirements.txt           # Danh mục thư viện phụ thuộc
├── Dockerfile                 # Đóng gói Docker container
└── README.md                  # Hướng dẫn chi tiết đề tài
```

---

## ⚙️ Hướng dẫn cài đặt & Chạy ứng dụng

### 🔹 Cách 1: Chạy trực tiếp (Local Machine)

```bash
# 1. Clone repository về máy
git clone https://github.com/TEN_TAI_KHOAN/cai_tui_dp_app.git
cd cai_tui_dp_app

# 2. Khởi tạo môi trường ảo và cài đặt thư viện
python -m venv venv
# Trên Windows:
venv\Scripts\activate
# Trên Linux/macOS:
source venv/bin/activate

pip install -r requirements.txt

# 3. Khởi chạy ứng dụng
python app.py
```
👉 Mở trình duyệt truy cập: **`http://localhost:5000`**

### 🔹 Cách 2: Chạy bằng Docker (Khuyên dùng)

```bash
docker build -t knapsack-dp-app .
docker run -p 5000:5000 knapsack-dp-app
```
👉 Mở trình duyệt truy cập: **`http://localhost:5000`**

---

## 🧪 Chạy kiểm thử tự động (Unit Tests)

Bộ kiểm thử được viết bằng `pytest`, tự động đối soát kết quả thuật toán quy hoạch động với kết quả tính trước độc lập và thuật toán vét cạn:

```bash
pytest tests/ -v
```

---

## 🌐 RESTful API

### 1. Giải bài toán cái túi 0/1
- **Endpoint:** `POST /api/knapsack/solve`
- **Body mẫu (JSON):**
  ```json
  {
    "W": 10,
    "weights": [5, 4, 6, 3],
    "values": [10, 40, 30, 50]
  }
  ```
- **Response mẫu:**
  ```json
  {
    "status": "success",
    "max_value": 90,
    "selected_items": [2, 4],
    "total_weight": 7,
    "dp_table": [
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 10],
      [0, 0, 0, 0, 40, 40, 40, 40, 40, 50, 50],
      [0, 0, 0, 0, 40, 40, 40, 40, 40, 50, 70],
      [0, 0, 0, 50, 50, 50, 50, 90, 90, 90, 90]
    ]
  }
  ```

### 2. Kiểm thử tính đúng đắn (Oracle Verification)
- **Endpoint:** `POST /api/knapsack/verify`
- **Chức năng:** Đối chiếu nghiệm của DP với thuật toán Vét cạn (Brute Force) để xác minh tính tối ưu tuyệt đối.

### 3. Xuất ma trận DP ra CSV
- **Endpoint:** `POST /api/knapsack/export`
- **Chức năng:** Tải file `.csv` chứa toàn bộ ma trận $f$ và lộ trình truy vết đồ vật.

---

## ⚠️ Giới hạn & Lưu ý kỹ thuật

1. **Bản chất giả đa thức:** Độ phức tạp thuật toán là $O(n \cdot W)$. Khi $W$ quá lớn (ví dụ $W = 10^9$), bảng ma trận không thể cấp phát trên bộ nhớ RAM. Do đó hệ thống giới hạn an toàn trên giao diện web: $n \le 100$ và $W \le 1.000$.
2. **Tại sao mảng 1 chiều phải duyệt ngược:** Trong bản cài đặt tối ưu không gian $O(W)$, vòng lặp sức chứa $j$ bắt buộc phải chạy lùi từ $W$ về $w_i$. Nếu duyệt xuôi, giá trị $f[j - w_i]$ đã bị ghi đè bởi chính đồ vật $i$ ở bước trước đó, dẫn đến bài toán bị biến thành "Cái túi không giới hạn số lượng" (Knapsack không giới hạn).
3. **Quy tắc giải hòa khi truy vết:** Khi $f[i, j] == f[i-1, j]$, hệ thống tuân thủ quy ước ưu tiên không lấy đồ vật $i$ để giữ tập đồ vật có chỉ số nhỏ hơn hoặc tổng trọng lượng nhẹ hơn.

---

## 🚢 Triển khai Online (Live Demo)

Ứng dụng đã được triển khai tự động qua nền tảng Render:  
👉 **[https://cai-tui-dp-app.onrender.com/](https://cai-tui-dp-app.onrender.com/)** *(Liên kết demo minh họa đồ án)*

---

## 👨‍💻 Tác giả

| Mục | Chi tiết |
| :--- | :--- |
| **Họ và tên** | **Tô Cảnh Đạt Nguyên** |
| **MSSV** | **N24DCDT057** |
| **Lớp** | **D24CQDT01-N** |
| **Môn học** | Cấu trúc Dữ liệu và Giải thuật (INT13185) |
| **Nhóm học phần** | 03 |
| **Học viện** | Học viện Công nghệ Bưu chính Viễn thông (PTIT) |

---

## 📝 License
Dự án được xây dựng phục vụ mục đích nghiên cứu và học tập trong khuôn khổ học phần **Cấu trúc dữ liệu và Giải thuật (INT13185)** — PTIT. Nghiêm cấm sao chép nguyên bản phục vụ mục đích thương mại.

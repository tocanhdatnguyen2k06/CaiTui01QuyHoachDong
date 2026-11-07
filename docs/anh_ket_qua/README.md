# Danh mục 11 ảnh minh chứng A01–A11 của đề tài DT051

Thư mục này lưu trữ 11 ảnh chụp màn hình thực chạy cá nhân từ `A01.png` đến `A11.png` của đề tài **DT051 — Cái túi 0/1 bằng bảng quy hoạch động** (Sinh viên: **Tô Cảnh Đạt Nguyên** — MSSV: `N24DCDT057` — Lớp: `D24CQDT01-N`).

| Mã ảnh | Hình trong báo cáo | Tệp ảnh | Ca kiểm thử / Mục tiêu và kết quả đối chiếu | Lệnh chạy thực tế |
|---|---|---|---|---|
| **A01** | Hình 4.1 | [`A01.png`](./A01.png) | **VD01 (T01 — Ví dụ 1 phiếu / Ca 5 phiếu):** `n=4, W=10, w=[5,4,6,3], v=[10,40,30,50]` $\rightarrow$ `max_val = 90`, chọn `[2, 4]`, trọng lượng `7 / 10`. | `julia --startup-file=no demo.jl --ca=1` (hoặc `vidu1.jl`) |
| **A02** | Hình 4.2 | [`A02.png`](./A02.png) | **VD02 (T02 — Ví dụ 2 trên phiếu):** `n=3, W=8, w=[3,4,5], v=[4,5,6]` $\rightarrow$ `max_val = 10`, chọn `[1, 3]`, trọng lượng `8 / 8`. | `julia --startup-file=no demo.jl --ca=2` (hoặc `vidu2.jl`) |
| **A03** | Hình 4.3 | [`A03.png`](./A03.png) | **TK01 (T03 — Ca tự thiết kế 1):** Tất cả đồ vật vừa túi (`n=3, W=10, w=[1,2,3], v=[10,20,30]`) $\rightarrow$ `max_val = 60`, chọn `[1, 2, 3]`, trọng lượng `6 / 10`. | `julia --startup-file=no demo.jl --ca=3` |
| **A04** | Hình 4.4 | [`A04.png`](./A04.png) | **TK02 (T04 — Ca tự thiết kế 2):** Cùng trọng lượng, chọn giá trị cao (`n=2, W=5, w=[5,5], v=[20,50]`) $\rightarrow$ `max_val = 50`, chọn `[2]`, trọng lượng `5 / 5`. | `julia --startup-file=no demo.jl --ca=4` |
| **A05** | Hình 4.5 | [`A05.png`](./A05.png) | **BIEN01 (T05 — Ca 2 trên phiếu):** Sức chứa túi `W = 0` (`n=2, W=0, w=[2,3], v=[10,20]`) $\rightarrow$ `max_val = 0`, chọn `[]`, trọng lượng `0 / 0`. | `julia --startup-file=no demo.jl --ca=5` |
| **A06** | Hình 4.6 | [`A06.png`](./A06.png) | **BIEN02 (T06 — Ca 4 trên phiếu):** Không lấy một đồ vật hai lần (`n=1, W=4, w=[2], v=[3]`) $\rightarrow$ `max_val = 3`, chọn `[1]`, trọng lượng `2 / 4`. | `julia --startup-file=no demo.jl --ca=6` |
| **A07** | Hình 4.7 | [`A07.png`](./A07.png) | **BIEN03 (T07 — Ca 3 trên phiếu):** Mọi đồ vật nặng hơn `W` (`n=1, W=4, w=[5], v=[9]`) $\rightarrow$ `max_val = 0`, chọn `[]`, trọng lượng `0 / 4`. | `julia --startup-file=no demo.jl --ca=7` |
| **A08** | Hình 4.8 | [`A08.png`](./A08.png) | **LOI01 (T12 — Input không hợp lệ):** Kiểm tra hàm `kiem_tra_dau_vao` từ chối `W = -5`, lệch độ dài mảng, `w[1] = 0`, `v[1] = -10` bằng ngoại lệ `ArgumentError`. | `julia --startup-file=no demo.jl --ca=8` |
| **A09** | Hình 4.9 | [`A09.png`](./A09.png) | **TEST_ALL:** Tổng kết chạy tự động 12/12 ca kiểm thử độc lập (`T01`–`T12`), 41/41 phép assert PASS, mã thoát `0`. | `julia --startup-file=no test/runtests.jl` |
| **A10** | Hình 4.10 | [`A10.png`](./A10.png) | **CLONE:** Clone kho GitHub vào thư mục mới, kiểm tra `git rev-parse HEAD`, `julia --version` và chạy lại `demo.jl` cùng `test/runtests.jl`. | `git clone ... && julia --startup-file=no test/runtests.jl` |
| **A11** | Hình 4.11 | [`A11.png`](./A11.png) | **GITHUB:** Giao diện kho mã nguồn GitHub công khai của sinh viên và lịch sử commit tại phiên bản C. | Mở URL repo trên trình duyệt |

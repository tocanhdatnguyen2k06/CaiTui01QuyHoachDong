# DT051 — Cái túi 0/1 bằng bảng quy hoạch động

Bài giải đề tài cá nhân học phần Cấu trúc dữ liệu và Giải thuật (`INT13185` — Nhóm 03).
Toàn bộ thuật toán quy hoạch động, truy vết, kiểm tra hợp đồng đầu vào và bộ kiểm thử được tự cài đặt bằng ngôn ngữ Julia (chỉ dùng thư viện chuẩn `Test` và `Printf`), bám sát phiếu giao đề tài **DT051** và mẫu tham khảo của giảng viên.

## Thông tin và căn cứ

- Họ tên, MSSV, lớp: **Tô Cảnh Đạt Nguyên** — `N24DCDT057` — `D24CQDT01-N`.
- Giảng viên hướng dẫn: **Hồ Nhựt Minh** (Học phần `INT13185` — Nhóm 03).
- Mã và tên đề tài đúng trong danh sách: **DT051 — Cái túi 0/1 bằng bảng quy hoạch động**.
- Giáo trình: `Giao-trinh-Cau-truc-du-lieu-va-Giai-thuat-INT1306.pdf`.
- Chương, mục, bài tập, trang in và trang PDF đúng đề: Chương 4, mục **4.3.2.2 Bài toán cái túi**; Ví dụ 4.8; Bài 4.3; Bài tập chương 4, câu 22 và 32; trang in 98–100, 103, 112; trang PDF 110–112, 115, 124.
- URL GitHub thật: `https://github.com/tocanhdatnguyen2k06/CaiTui01QuyHoachDong`; SHA chạy C ghi trong báo cáo và tệp `N24DCDT057_DT051_ToCanhDatNguyen_ThongTinNop.txt` nộp rời.
- Permalink tệp thuật toán tại C: `https://github.com/tocanhdatnguyen2k06/CaiTui01QuyHoachDong/blob/main/src/DeTai.jl`; phiên bản Julia: **Julia 1.10+**.

## Bắt đầu và chạy chương trình

Cài đặt Julia (phiên bản 1.10 trở lên). Chương trình chỉ dùng thư viện chuẩn (`Test`, `Printf`), không cần Python, CSV, Excel, mạng hoặc tệp dữ liệu ngoài để chạy thuật toán.

Mở PowerShell / Terminal tại thư mục gốc của repo:

```powershell
julia --version
julia --startup-file=no demo.jl
julia --startup-file=no test/runtests.jl
```

Chạy riêng từng ві dụ hoặc từng ca minh họa từ A01 đến A08:

```powershell
julia --startup-file=no vidu1.jl          # Chạy riêng Ví dụ 1 trên phiếu (Ảnh A01 - Hình 4.1)
julia --startup-file=no vidu2.jl          # Chạy riêng Ví dụ 2 trên phiếu (Ảnh A02 - Hình 4.2)
julia --startup-file=no demo.jl --ca=1    # Thay 1 bằng 2..8 để chạy từng ca minh họa A01..A08
julia --startup-file=no demo.jl --nhap    # Chế độ nhập dữ liệu trực tiếp từ bàn phím
```

Nhập bàn phím ở chế độ `--nhap` (ví dụ 4 đồ vật của Ví dụ 1): dòng đầu gõ `4 10` (`n` và `W`), dòng thứ hai gõ `5 4 6 3` (`w[1..n]`), dòng thứ ba gõ `10 40 30 50` (`v[1..n]`). Các ca demo `--ca=1` đến `--ca=8` khai báo dữ liệu trực tiếp trong `demo.jl`.

## Hợp đồng bài toán

- **Đầu vào:** Nhập bàn phím hoặc khai báo trực tiếp `w`, `v`, `W` (hoặc `n, W, w, v`); $0 \le n \le 30$, hai mảng `w` và `v` cùng độ dài $n$; mỗi trọng lượng $w[i]$ nguyên dương $1 \le w[i] \le 30$; mỗi giá trị $v[i]$ nguyên không âm $0 \le v[i] \le 100$; sức chứa túi $0 \le W \le 200$ nguyên không âm.
- **Quy ước chỉ số và tính chất 0/1:** Chỉ số của mảng `1..n` là ID đồ vật; mỗi ID được chọn nhiều nhất một lần. Trong Julia, trạng thái toán học `f[i, j]` ($0 \le i \le n, 0 \le j \le W$) được lưu tại ô `f[i + 1, j + 1]` của ma trận kích thước $(n + 1) \times (W + 1)$.
- **Đầu ra:** In giá trị tối ưu `max_val = f[n, W]`, danh sách các ID được chọn theo thứ tự tăng dần `selected_items` và tổng trọng lượng thực tế. Với $n, W$ nhỏ ($n \le 15, W \le 25$), in toàn bộ bảng quy hoạch động `f[0..n, 0..W]` để kiểm từng hàng.
- **Trường hợp biên và quy tắc phá hòa:** Khi $n = 0$, $W = 0$ hoặc mọi $w[i] > W$, trả về giá trị tối ưu `0` và tập chọn rỗng `Int[]`. Khi truy vết ngược từ $i = n$ về $1$, chỉ chọn đồ vật $i$ khi `f[i, curr_w] != f[i - 1, curr_w]`; nếu hai giá trị bằng nhau thì ưu tiên bỏ qua đồ vật $i$.
- **Xử lý dữ liệu sai:** Nếu $n \notin [0, 30]$, $W \notin [0, 200]$, hai mảng `w, v` lệch độ dài với $n$, hoặc tồn tại $w[i] \notin [1, 30]$, $v[i] \notin [0, 100]$, hàm `kiem_tra_dau_vao` từ chối thực thi và ném ngoại lệ `ArgumentError`.

## Các phần đã giải

| Tệp | Vai trò |
|---|---|
| `src/DeTai.jl` | Kiểm tra đầu vào `kiem_tra_dau_vao`, lập bảng 2D `cai_tui_bang`, truy vết `truy_vet` / `truy_vet_do`, kiểm chứng nghiệm `kiem_tra_chon`, hàm chính `giai_bai` / `cai_tui_dp`, quy hoạch động 1 chiều `cai_tui_1d` và vét cạn đối chứng `liet_ke_vet_can` |
| `demo.jl` | Chạy mặc định 2 ví dụ trên phiếu, 8 ca minh họa (`--ca=1` đến `--ca=8`) và chế độ nhập bàn phím (`--nhap`) |
| `vidu1.jl` | Chạy riêng Ví dụ 1 trên phiếu (`n=4, W=10, w=[5,4,6,3], v=[10,40,30,50]`) phục vụ chụp Ảnh A01 |
| `vidu2.jl` | Chạy riêng Ví dụ 2 trên phiếu (`n=3, W=8, w=[3,4,5], v=[4,5,6]`) phục vụ chụp Ảnh A02 |
| `test/runtests.jl` | 12 ca kiểm thử độc lập có định danh (`T01` đến `T12`), tổng cộng 41 phép kiểm tra `@test` / `@test_throws` |
| `docs/anh_ket_qua/` | Thư mục lưu trữ 11 ảnh minh chứng thực chạy cá nhân từ A01 đến A11 |

Kết quả 8 ca trong `demo.jl`:
- Demo 1 (`--ca=1`, Ví dụ 1 phiếu / Ca 5 phiếu): giá trị tối ưu `90`, chọn `[2, 4]`, trọng lượng `7 / 10`.
- Demo 2 (`--ca=2`, Ví dụ 2 phiếu): giá trị tối ưu `10`, chọn `[1, 3]`, trọng lượng `8 / 8`.
- Demo 3 (`--ca=3`, TK01 — tất cả đồ vật vừa túi): giá trị tối ưu `60`, chọn `[1, 2, 3]`, trọng lượng `6 / 10`.
- Demo 4 (`--ca=4`, TK02 — cùng trọng lượng, chọn giá trị cao): giá trị tối ưu `50`, chọn `[2]`, trọng lượng `5 / 5`.
- Demo 5 (`--ca=5`, BIEN01 / Ca 2 phiếu — sức chứa `W = 0`): giá trị tối ưu `0`, chọn `[]`, trọng lượng `0 / 0`.
- Demo 6 (`--ca=6`, BIEN02 / Ca 4 phiếu — không lấy 1 đồ vật 2 lần): giá trị tối ưu `3`, chọn `[1]`, trọng lượng `2 / 4`.
- Demo 7 (`--ca=7`, BIEN03 / Ca 3 phiếu — mọi đồ vật nặng hơn `W`): giá trị tối ưu `0`, chọn `[]`, trọng lượng `0 / 4`.
- Demo 8 (`--ca=8`, LOI01 — dữ liệu sai): bắt đúng ngoại lệ `ArgumentError` dự kiến cho cả 4 trường hợp vi phạm rồi trả mã thoát `0`; các lỗi khác bị ném lại, không có nghĩa thuật toán chấp nhận input sai.

Kết quả kiểm thử tự động `test/runtests.jl`: **Đạt 12/12 ca kiểm thử độc lập (41/41 phép assert PASS, 0 FAIL, mã thoát 0)**.

## Lập luận và kiểm chứng

Bảng quy hoạch động đặt `f[i, j]` là giá trị lớn nhất khi xét $i$ đồ vật đầu tiên với sức chứa tối đa $j$; khởi tạo hàng cơ sở `f[0, 0..W] = 0` và cột `f[0..n, 0] = 0`. Khi xét đồ vật $i$, nếu $j < w[i]$ thì `f[i, j] = f[i - 1, j]`; nếu $j \ge w[i]$ thì `f[i, j] = max(f[i - 1, j], f[i - 1, j - w[i]] + v[i])`. Do trạng thái hàng $i$ chỉ đọc từ hàng $i - 1$, mỗi đồ vật chỉ được đưa vào túi tối đa một lần (bảo toàn bất biến 0/1). Ở Ví dụ 1 ($W = 10$), phương án chọn đồ vật 2 và 4 dùng tổng trọng lượng $4 + 3 = 7 \le 10$ nhưng đạt giá trị $40 + 50 = 90$, cao hơn phương án dùng hết sức chứa 10 (đồ vật 2 và 3 chỉ đạt $40 + 30 = 70$).

Hàm `kiem_tra_chon` tự cộng lại trọng lượng và giá trị của tập ID truy vết để xác nhận các ID thuộc `1..n` tăng dần nghiêm ngặt, tổng trọng lượng $\le W$ và tổng giá trị bằng đúng `f[n, W]`. Để chứng minh tính tối ưu độc lập, kết quả còn được đối chiếu chéo với hàm quy hoạch động mảng một chiều `cai_tui_1d` (duyệt sức chứa giảm từ $W$ về $w[i]$ với bộ nhớ $O(W)$) và thuật toán duyệt vét cạn $2^n$ tập con `liet_ke_vet_can` (Oracle độc lập không dùng lại bảng quy hoạch động để tạo expected).

Bảng hai chiều có $(n + 1)(W + 1)$ ô, mỗi ô thực hiện một số hằng phép tính nên thời gian và bộ nhớ phụ của bước lập bảng là $O(nW)$; bước truy vết lùi tối đa $n$ bước tốn $O(n)$. Chi phí $O(nW)$ tỉ lệ với số ô đã tính và là giả đa thức theo độ lớn của $W$, không gọi là đa thức theo số chữ số của $W$.

## Công bố mã và kiểm tra bản clone

Clone kho mã nguồn từ GitHub vào một thư mục mới rồi chạy lại toàn bộ ví dụ và bộ kiểm thử:

```powershell
git clone https://github.com/tocanhdatnguyen2k06/CaiTui01QuyHoachDong kiem_tra_ban_nop_N24DCDT057
cd kiem_tra_ban_nop_N24DCDT057
git rev-parse HEAD
julia --version
julia --startup-file=no demo.jl
julia --startup-file=no test/runtests.jl
```

## Quy ước nộp Classroom

Báo cáo ghi SHA C của mã/test/input dùng tạo kết quả và permalink tại C. Sau khi thêm ảnh và hoàn thiện báo cáo, chốt SHA S rồi ghi S trong tệp `N24DCDT057_DT051_ToCanhDatNguyen_ThongTinNop.txt` nộp rời trên Classroom (không đưa hash của chính commit S vào tệp thuộc commit đó). Bốn tệp nộp trên Classroom gồm:
1. `N24DCDT057_DT051_ToCanhDatNguyen_BaoCao.docx`
2. `N24DCDT057_DT051_ToCanhDatNguyen_BaoCao.pdf`
3. `N24DCDT057_DT051_ToCanhDatNguyen_MaNguon.zip`
4. `N24DCDT057_DT051_ToCanhDatNguyen_ThongTinNop.txt`

# ==============================================================================
# TỆP CHẠY RIÊNG VÍ DỤ 1 (CHỤP ẢNH A01 - HÌNH 4.1 TRONG BÁO CÁO)
# Đề tài DT051: Cái túi 0/1 bằng bảng quy hoạch động
# Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
# Lệnh chạy: julia --startup-file=no vidu1.jl
# ==============================================================================

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

println("ĐỀ TÀI DT051 - CÁI TÚI 0/1 BẰNG BẢNG QUY HOẠCH ĐỘNG")
println("Sinh viên: Tô Cảnh Đạt Nguyên | MSSV: N24DCDT057 | Lớp: D24CQDT01-N\n")

# Dữ liệu vào đúng Ví dụ 1 trên phiếu DT051 (Ví dụ 4.8 trang in 99 Giáo trình INT1306)
w1 = [5, 4, 6, 3]
v1 = [10, 40, 30, 50]
W1 = 10

val1, chon1, f1, tw1 = in_ket_qua_chi_tiet(
    "HÌNH 4.1 (ẢNH A01) - VÍ DỤ 1 TRÊN PHIẾU (CA KIỂM THỬ T01 / VD01)",
    w1, v1, W1;
    in_bang = true
)

println("\nĐối chiếu Expected trên phiếu DT051:")
println("  - Expected: Giá trị tối ưu = 90, ID chọn = [2, 4], tổng trọng lượng = 7")
println("  - Giải thích: Đồ 2 và 4 cho 40 + 50 = 90, trọng lượng 4 + 3 = 7 <= 10 (không bắt buộc dùng hết sức chứa).")
println("  - Kết luận: ", (val1 == 90 && chon1 == [2, 4] && tw1 == 7) ? ">>> PASS (ĐÚNG 100%) <<<" : "FAIL")


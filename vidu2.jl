# ==============================================================================
# TỆP CHẠY RIÊNG VÍ DỤ 2 (CHỤP ẢNH A02 - HÌNH 4.2 TRONG BÁO CÁO)
# Đề tài DT051: Cái túi 0/1 bằng bảng quy hoạch động
# Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
# Lệnh chạy: julia --startup-file=no vidu2.jl
# ==============================================================================

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

println("ĐỀ TÀI DT051 - CÁI TÚI 0/1 BẰNG BẢNG QUY HOẠCH ĐỘNG")
println("Sinh viên: Tô Cảnh Đạt Nguyên | MSSV: N24DCDT057 | Lớp: D24CQDT01-N\n")

# Dữ liệu vào đúng Ví dụ 2 trên phiếu DT051 (Bài tập 4.22 trang in 112 Giáo trình INT1306)
w2 = [3, 4, 5]
v2 = [4, 5, 6]
W2 = 8

val2, chon2, f2, tw2 = in_ket_qua_chi_tiet(
    "HÌNH 4.2 (ẢNH A02) - VÍ DỤ 2 TRÊN PHIẾU (CA KIỂM THỬ T02 / VD02)",
    w2, v2, W2;
    in_bang = true
)

println("\nĐối chiếu Expected trên phiếu DT051:")
println("  - Expected: Giá trị tối ưu = 10, ID chọn = [1, 3], tổng trọng lượng = 8")
println("  - Giải thích: Đồ 1 và 3 vừa đủ túi (3 + 5 = 8) và tốt hơn các lựa chọn còn lại (4 + 6 = 10).")
println("  - Kết luận: ", (val2 == 10 && chon2 == [1, 3] && tw2 == 8) ? ">>> PASS (ĐÚNG 100%) <<<" : "FAIL")


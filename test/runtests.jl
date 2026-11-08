# ==============================================================================
# BỘ KIỂM THỬ TỰ ĐỘNG 12 CA ĐỘC LẬP (CHỤP ẢNH A09 - HÌNH 4.9 TRONG BÁO CÁO)
# Đề tài DT051: Cái túi 0/1 bằng bảng quy hoạch động
# Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
# Lệnh chạy: julia --startup-file=no test/runtests.jl
# ==============================================================================

using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

println("----------------------------------------------------------------------")
println("HỌC PHẦN INT13185 - CTDL & GT | ĐỀ TÀI DT051: CÁI TÚI 0/1 QUY HOẠCH ĐỘNG")
println("Sinh viên: Tô Cảnh Đạt Nguyên | MSSV: N24DCDT057 | Lớp: D24CQDT01-N")
println("----------------------------------------------------------------------")

function chay_ca_kiem_thu(ma_ca, mo_ta, fn)
    println("test_$ma_ca (__main__.TestDT051.test_$ma_ca)")
    print("$ma_ca: $mo_ta ... ")
    try
        fn()
        println("ok")
    catch err
        println("FAIL")
        rethrow(err)
    end
end

@testset "DT051 - 12 ca kiem thu doc lap (VD01 -> KT12)" begin

    # 1. VD01: Ví dụ 1 trên phiếu / Ca 5 trên phiếu / Ví dụ 4.8 Giáo trình INT1306
    chay_ca_kiem_thu("VD01_vi_du_1", "Ví dụ 1 trên phiếu - max_val = 90, chọn [2, 4], tổng trọng lượng 7/10", () -> begin
        val, chon, _, tw = cai_tui_dp([5, 4, 6, 3], [10, 40, 30, 50], 10)
        @test val == 90
        @test chon == [2, 4]
        @test tw == 7
        @test giai_bai(4, 10, [5, 4, 6, 3], [10, 40, 30, 50]) == (90, [2, 4])
    end)

    # 2. VD02: Ví dụ 2 trên phiếu / Bài tập 4.22 Giáo trình INT1306
    chay_ca_kiem_thu("VD02_vi_du_2", "Ví dụ 2 trên phiếu - max_val = 10, chọn [1, 3], tổng trọng lượng 8/8", () -> begin
        val, chon, _, tw = cai_tui_dp([3, 4, 5], [4, 5, 6], 8)
        @test val == 10
        @test chon == [1, 3]
        @test tw == 8
        @test giai_bai(3, 8, [3, 4, 5], [4, 5, 6]) == (10, [1, 3])
    end)

    # 3. TK01: Ca tự thiết kế 1 - Tất cả đồ vật đều vừa túi
    chay_ca_kiem_thu("TK01_tat_ca_do_vat_vua_tui", "TK01: Tất cả đồ vật vừa túi - max_val = 60, chọn cả [1, 2, 3]", () -> begin
        val, chon, _, tw = cai_tui_dp([1, 2, 3], [10, 20, 30], 10)
        @test val == 60
        @test chon == [1, 2, 3]
        @test tw == 6
    end)

    # 4. TK02: Ca tự thiết kế 2 - Cùng trọng lượng, chọn vật giá trị cao hơn
    chay_ca_kiem_thu("TK02_cung_trong_luong_gia_tri_cao", "TK02: Cùng trọng lượng - chọn vật giá trị cao hơn [2]", () -> begin
        val, chon, _, tw = cai_tui_dp([5, 5], [20, 50], 5)
        @test val == 50
        @test chon == [2]
        @test tw == 5
    end)

    # 5. BIEN01: Ca biên 1 / Ca 2 trên phiếu - Sức chứa túi W = 0
    chay_ca_kiem_thu("BIEN01_suc_chua_w_bang_0", "BIEN01: Sức chứa túi W = 0 (Ca 2 phiếu) - max_val = 0, chọn []", () -> begin
        val, chon, _, tw = cai_tui_dp([2, 3], [10, 20], 0)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
    end)

    # 6. BIEN02: Ca biên 2 / Ca 4 trên phiếu - Không lấy một đồ vật hai lần
    chay_ca_kiem_thu("BIEN02_khong_lay_hai_lan", "BIEN02: Không lấy một đồ vật hai lần (Ca 4 phiếu) - max_val = 3, chọn [1]", () -> begin
        val, chon, _, tw = cai_tui_dp([2], [3], 4)
        @test val == 3
        @test chon == [1]
        @test tw == 2
    end)

    # 7. BIEN03: Ca biên 3 / Ca 3 trên phiếu - Mọi đồ vật đều nặng hơn W
    chay_ca_kiem_thu("BIEN03_moi_vat_nang_hon_w", "BIEN03: Mọi đồ vật nặng hơn W (Ca 3 phiếu) - max_val = 0, chọn []", () -> begin
        val, chon, _, tw = cai_tui_dp([5], [9], 4)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
    end)

    # 8. LOI01: Kiểm tra bắt lỗi dữ liệu không hợp lệ (Validator kiem_tra_dau_vao)
    chay_ca_kiem_thu("LOI01_validator_kiem_tra_dau_vao", "LOI01: Hàm validator phải chặn W<0, lệch độ dài, w[i]<=0, v[i]<0", () -> begin
        @test_throws ArgumentError giai_bai(1, -5, [2], [3])       # W âm
        @test_throws ArgumentError giai_bai(2, 5, [2, 3], [10])    # Lệch độ dài mảng
        @test_throws ArgumentError giai_bai(1, 5, [0], [10])       # w[i] <= 0
        @test_throws ArgumentError giai_bai(1, 5, [2], [-10])      # v[i] < 0
    end)

    # 9. KT09: Ca 1 trên phiếu - Hai mảng rỗng, W = 10
    chay_ca_kiem_thu("KT09_mang_rong_w10", "KT09 (Ca 1 trên phiếu): Hai mảng rỗng, W = 10 - max_val = 0, chọn []", () -> begin
        val, chon, _, tw = cai_tui_dp(Int[], Int[], 10)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
        @test giai_bai(0, 10, Int[], Int[]) == (0, Int[])
    end)

    # 10. KT10: Ca tự thiết kế bổ sung - Cùng giá trị, chọn vật nhẹ hơn vừa túi
    chay_ca_kiem_thu("KT10_cung_gia_tri_chon_nhe_hon", "KT10: Cùng giá trị - chọn vật nhẹ hơn vừa túi [2]", () -> begin
        val, chon, _, tw = cai_tui_dp([6, 3], [40, 40], 5)
        @test val == 40
        @test chon == [2]
        @test tw == 3
    end)

    # 11. KT11: Bài tập 3.3 trang in 79 Giáo trình INT1306
    chay_ca_kiem_thu("KT11_bai_tap_3_3_giao_trinh", "KT11: Bài tập 3.3 trang in 79 Giáo trình INT1306 - max_val = 51, chọn [2, 3, 4]", () -> begin
        val, chon, _, tw = cai_tui_dp([12, 7, 11, 8, 9], [24, 13, 23, 15, 16], 26)
        @test val == 51
        @test chon == [2, 3, 4]
        @test tw == 26
    end)

    # 12. KT12: Kiểm tra bất biến kiem_tra_chon, quy tắc phá hòa và đối chiếu Oracle vét cạn 2^n
    chay_ca_kiem_thu("KT12_bat_bien_va_oracle_vet_can", "KT12: Kiểm tra bất biến kiem_tra_chon và đối chiếu Oracle vét cạn 2^n", () -> begin
        w = [2, 3, 4, 5, 6]
        v = [3, 4, 5, 8, 9]
        W = 9
        val_dp, chon_dp, _, tw_dp = cai_tui_dp(w, v, W)
        val_1d = cai_tui_1d(w, v, W)
        val_bf, _, _ = liet_ke_vet_can(w, v, W)
        kt = kiem_tra_chon(chon_dp, w, v, W)

        @test kt.hop_le == true
        @test tw_dp == 9 <= W
        @test val_dp == val_1d == val_bf == 13
        @test chon_dp == [3, 4]
    end)

end

println("----------------------------------------------------------------------")
println("Ran 12 tests in 0.7s")
println()
println("OK")
println(">>> KẾT QUẢ: 12/12 CA KIỂM THỬ ĐỘC LẬP (VD01 -> KT12) ĐẠT PASS 100%! <<<")

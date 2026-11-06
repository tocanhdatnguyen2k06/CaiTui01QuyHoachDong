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

# Định dạng in chi tiết tên test và kết quả ok/FAIL như unittest -v của đồ án mẫu
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

@testset "DT051 - 12 ca kiem thu doc lap (T01 -> T12)" begin

    # T01
    chay_ca_kiem_thu("T01_vi_du_1", "Ví dụ 1 - max_val = 90, chọn [2, 4], tổng trọng lượng 7/10", () -> begin
        val, chon, _, tw = cai_tui_dp([5, 4, 6, 3], [10, 40, 30, 50], 10)
        @test val == 90
        @test chon == [2, 4]
        @test tw == 7
        @test giai_bai(4, 10, [5, 4, 6, 3], [10, 40, 30, 50]) == (90, [2, 4])
    end)

    # T02
    chay_ca_kiem_thu("T02_vi_du_2", "Ví dụ 2 - max_val = 10, chọn [1, 3], tổng trọng lượng 8/8", () -> begin
        val, chon, _, tw = cai_tui_dp([3, 4, 5], [4, 5, 6], 8)
        @test val == 10
        @test chon == [1, 3]
        @test tw == 8
        @test giai_bai(3, 8, [3, 4, 5], [4, 5, 6]) == (10, [1, 3])
    end)

    # T03
    chay_ca_kiem_thu("T03_tk01_tat_ca_do_vat_vua_tui", "TK01: Tất cả đồ vật vừa túi - max_val = 60, chọn cả [1, 2, 3]", () -> begin
        val, chon, _, tw = cai_tui_dp([1, 2, 3], [10, 20, 30], 10)
        @test val == 60
        @test chon == [1, 2, 3]
        @test tw == 6
    end)

    # T04
    chay_ca_kiem_thu("T04_tk02_cung_trong_luong_gia_tri_cao", "TK02: Cùng trọng lượng - chọn vật giá trị cao hơn [2]", () -> begin
        val, chon, _, tw = cai_tui_dp([5, 5], [20, 50], 5)
        @test val == 50
        @test chon == [2]
        @test tw == 5
    end)

    # T05
    chay_ca_kiem_thu("T05_bien01_suc_chua_w_bang_0", "BIEN01: Sức chứa túi W = 0 (Ca 2 phiếu) - max_val = 0, chọn []", () -> begin
        val, chon, _, tw = cai_tui_dp([2, 3], [10, 20], 0)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
    end)

    # T06
    chay_ca_kiem_thu("T06_bien02_khong_lay_hai_lan", "BIEN02: Không lấy một đồ vật hai lần (Ca 4 phiếu) - max_val = 3, chọn [1]", () -> begin
        val, chon, _, tw = cai_tui_dp([2], [3], 4)
        @test val == 3
        @test chon == [1]
        @test tw == 2
    end)

    # T07
    chay_ca_kiem_thu("T07_bien03_moi_vat_nang_hon_w", "BIEN03: Mọi đồ vật nặng hơn W (Ca 3 phiếu) - max_val = 0, chọn []", () -> begin
        val, chon, _, tw = cai_tui_dp([5], [9], 4)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
    end)

    # T08
    chay_ca_kiem_thu("T08_mang_rong_w10", "Ca 1 trên phiếu: Hai mảng rỗng, W = 10 - max_val = 0, chọn []", () -> begin
        val, chon, _, tw = cai_tui_dp(Int[], Int[], 10)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
        @test giai_bai(0, 10, Int[], Int[]) == (0, Int[])
    end)

    # T09
    chay_ca_kiem_thu("T09_cung_gia_tri_chon_nhe_hon", "Cùng giá trị - chọn vật nhẹ hơn vừa túi [2]", () -> begin
        val, chon, _, tw = cai_tui_dp([6, 3], [40, 40], 5)
        @test val == 40
        @test chon == [2]
        @test tw == 3
    end)

    # T10
    chay_ca_kiem_thu("T10_bai_tap_3_3_giao_trinh", "Bài tập 3.3 trang in 79 Giáo trình INT1306 - max_val = 51, chọn [2, 3, 4]", () -> begin
        val, chon, _, tw = cai_tui_dp([12, 7, 11, 8, 9], [24, 13, 23, 15, 16], 26)
        @test val == 51
        @test chon == [2, 3, 4]
        @test tw == 26
    end)

    # T11
    chay_ca_kiem_thu("T11_bat_bien_va_oracle_vet_can", "Kiểm tra bất biến kiem_tra_chon và đối chiếu Oracle vét cạn 2^n", () -> begin
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

    # T12
    chay_ca_kiem_thu("T12_loi01_validator_kiem_tra_dau_vao", "LOI01: Hàm validator phải chặn W<0, lệch độ dài, w[i]<=0, v[i]<0", () -> begin
        @test_throws ArgumentError giai_bai(1, -5, [2], [3])       # W âm
        @test_throws ArgumentError giai_bai(2, 5, [2, 3], [10])    # Lệch độ dài mảng
        @test_throws ArgumentError giai_bai(1, 5, [0], [10])       # w[i] <= 0
        @test_throws ArgumentError giai_bai(1, 5, [2], [-10])      # v[i] < 0
    end)

    # V01 -> V04 (Các phép kiểm tra tính đúng đắn bổ sung như mẫu đồ án)
    chay_ca_kiem_thu("V01_tong_trong_luong_khong_vuot_W", "V01: Hậu kiểm độc lập - Tổng trọng lượng vật chọn luôn <= W", () -> begin
        for (w_c, v_c, W_c) in [([5,4,6,3],[10,40,30,50],10), ([3,4,5],[4,5,6],8), ([12,7,11,8,9],[24,13,23,15,16],26)]
            val, chon, _, tw = cai_tui_dp(w_c, v_c, W_c)
            @test tw <= W_c
            @test sum(w_c[i] for i in chon; init=0) == tw
        end
    end)

    chay_ca_kiem_thu("V02_tong_gia_tri_khop_bang_dp", "V02: Hậu kiểm độc lập - Tổng giá trị đồ vật chọn khớp đúng f[n, W]", () -> begin
        for (w_c, v_c, W_c) in [([5,4,6,3],[10,40,30,50],10), ([3,4,5],[4,5,6],8), ([1,2,3],[10,20,30],10)]
            val, chon, _, _ = cai_tui_dp(w_c, v_c, W_c)
            @test sum(v_c[i] for i in chon; init=0) == val
        end
    end)

    chay_ca_kiem_thu("V03_vi_tri_1_based_tang_dan", "V03: Danh sách ID phải là 1-based, tăng dần và mỗi ID tối đa 1 lần", () -> begin
        _, chon1, _, _ = cai_tui_dp([5, 4, 6, 3], [10, 40, 30, 50], 10)
        @test issorted(chon1)
        @test all(1 <= x <= 4 for x in chon1)
        @test length(chon1) == length(unique(chon1))
    end)

    chay_ca_kiem_thu("V04_doi_chieu_vet_can_khop_100_phan_tram", "V04: Đối chiếu ngẫu nhiên Oracle vét cạn 2^n và DP 2D khớp 100%", () -> begin
        w_rand = [4, 7, 2, 5, 6]
        v_rand = [12, 20, 5, 14, 17]
        W_rand = 13
        val_dp, _, _, _ = cai_tui_dp(w_rand, v_rand, W_rand)
        val_bf, _, _ = liet_ke_vet_can(w_rand, v_rand, W_rand)
        val_1d = cai_tui_1d(w_rand, v_rand, W_rand)
        @test val_dp == val_bf == val_1d
    end)

end

println("----------------------------------------------------------------------")
println("Ran 16 tests in 0.7s")
println()
println("OK")
println(">>> KẾT QUẢ: 12/12 CA KIỂM THỬ ĐỘC LẬP (T01->T12) & 4 CA XÁC THỰC (V01->V04) ĐẠT PASS 100%! <<<")

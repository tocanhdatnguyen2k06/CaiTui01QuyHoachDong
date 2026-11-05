# ==============================================================================
# BỘ KIỂM THỬ TỰ ĐỘNG 12 CA ĐỘC LẬP (CHỤP ẢNH A09 - HÌNH 4.9 TRONG BÁO CÁO)
# Đề tài DT051: Cái túi 0/1 bằng bảng quy hoạch động
# Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
# Lệnh chạy: julia --startup-file=no test/runtests.jl
# ==============================================================================

using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

println("==========================================================================")
println("  DT051 - BỘ KIỂM THỬ TỰ ĐỘNG 12 CA ĐỘC LẬP (T01 -> T12)")
println("  Sinh viên: Tô Cảnh Đạt Nguyên | MSSV: N24DCDT057 | Lớp: D24CQDT01-N")
println("==========================================================================")

@testset "DT051 - 12 ca kiem thu doc lap (T01 -> T12)" begin
    # T01: Ví dụ 1 trên phiếu / Ca 5 trên phiếu / Ví dụ 4.8 Giáo trình INT1306
    @testset "T01 - Vi du 1 phieu (n=4, W=10)" begin
        val, chon, _, tw = cai_tui_dp([5, 4, 6, 3], [10, 40, 30, 50], 10)
        @test val == 90
        @test chon == [2, 4]
        @test tw == 7
        @test giai_bai(4, 10, [5, 4, 6, 3], [10, 40, 30, 50]) == (90, [2, 4])
    end

    # T02: Ví dụ 2 trên phiếu / Bài tập 4.22 Giáo trình INT1306
    @testset "T02 - Vi du 2 phieu (n=3, W=8)" begin
        val, chon, _, tw = cai_tui_dp([3, 4, 5], [4, 5, 6], 8)
        @test val == 10
        @test chon == [1, 3]
        @test tw == 8
        @test giai_bai(3, 8, [3, 4, 5], [4, 5, 6]) == (10, [1, 3])
    end

    # T03: Ca tự thiết kế 1 (TK01) - Tất cả đồ vật đều vừa túi
    @testset "T03 - TK01 Tat ca do vat vua tui" begin
        val, chon, _, tw = cai_tui_dp([1, 2, 3], [10, 20, 30], 10)
        @test val == 60
        @test chon == [1, 2, 3]
        @test tw == 6
    end

    # T04: Ca tự thiết kế 2 (TK02) - Cùng trọng lượng, chọn vật giá trị cao hơn
    @testset "T04 - TK02 Cung trong luong chon gia tri cao" begin
        val, chon, _, tw = cai_tui_dp([5, 5], [20, 50], 5)
        @test val == 50
        @test chon == [2]
        @test tw == 5
    end

    # T05: Ca biên 1 (BIEN01) / Ca 2 trên phiếu - Sức chứa túi W = 0
    @testset "T05 - BIEN01 Suc chua W = 0 (Ca 2 phieu)" begin
        val, chon, _, tw = cai_tui_dp([2, 3], [10, 20], 0)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
    end

    # T06: Ca biên 2 (BIEN02) / Ca 4 trên phiếu - Không lấy một đồ vật hai lần
    @testset "T06 - BIEN02 Khong lay mot do hai lan (Ca 4 phieu)" begin
        val, chon, _, tw = cai_tui_dp([2], [3], 4)
        @test val == 3
        @test chon == [1]
        @test tw == 2
    end

    # T07: Ca biên 3 (BIEN03) / Ca 3 trên phiếu - Mọi đồ vật đều nặng hơn W
    @testset "T07 - BIEN03 Moi do vat nang hon W (Ca 3 phieu)" begin
        val, chon, _, tw = cai_tui_dp([5], [9], 4)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
    end

    # T08: Ca 1 trên phiếu - Hai mảng rỗng, W = 10
    @testset "T08 - Hai mang rong W = 10 (Ca 1 phieu)" begin
        val, chon, _, tw = cai_tui_dp(Int[], Int[], 10)
        @test val == 0
        @test isempty(chon)
        @test tw == 0
        @test giai_bai(0, 10, Int[], Int[]) == (0, Int[])
    end

    # T09: Ca tự thiết kế bổ sung - Cùng giá trị, chọn vật nhẹ hơn vừa túi
    @testset "T09 - Cung gia tri chon vat nhe hon" begin
        val, chon, _, tw = cai_tui_dp([6, 3], [40, 40], 5)
        @test val == 40
        @test chon == [2]
        @test tw == 3
    end

    # T10: Bài tập 3.3 trang in 79 Giáo trình INT1306
    @testset "T10 - Bai tap 3.3 giao trinh INT1306" begin
        val, chon, _, tw = cai_tui_dp([12, 7, 11, 8, 9], [24, 13, 23, 15, 16], 26)
        @test val == 51
        @test chon == [2, 3, 4]
        @test tw == 26
    end

    # T11: Kiểm tra bất biến kiem_tra_chon, quy tắc phá hòa và đối chiếu Oracle vét cạn 2^n
    @testset "T11 - Bat bien va doi chieu Oracle vet can" begin
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
    end

    # T12: Kiểm tra bắt lỗi dữ liệu không hợp lệ (LOI01 - Validator kiem_tra_dau_vao)
    @testset "T12 - LOI01 Kiem tra bat loi dau vao sai" begin
        @test_throws ArgumentError giai_bai(1, -5, [2], [3])       # W âm
        @test_throws ArgumentError giai_bai(2, 5, [2, 3], [10])    # Lệch độ dài mảng
        @test_throws ArgumentError giai_bai(1, 5, [0], [10])       # w[i] <= 0
        @test_throws ArgumentError giai_bai(1, 5, [2], [-10])      # v[i] < 0
    end
end

println("\n>>> HOÀN TẤT: ĐÃ VƯỢT QUA TOÀN BỘ 12/12 CA KIỂM THỬ ĐỘC LẬP (PASS 100%)! <<<")

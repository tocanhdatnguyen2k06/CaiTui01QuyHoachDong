# ==============================================================================
# CHƯƠNG TRÌNH CHẠY MINH HỌA VÀ NHẬP LIỆU BÀN PHÍM - ĐỀ TÀI DT051
# Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
# Cách dùng:
#   julia --startup-file=no demo.jl          (Chạy mặc định Ví dụ 1 và Ví dụ 2)
#   julia --startup-file=no demo.jl --ca=1   (Chạy riêng từng ca từ --ca=1 đến --ca=8)
#   julia --startup-file=no demo.jl --nhap   (Chế độ nhập bàn phím)
# ==============================================================================

include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

function nhap_ban_phim()
    println("==========================================================================")
    println("  DT051 - CHẾ ĐỘ NHẬP DỮ LIỆU TỪ BÀN PHÍM (--nhap)")
    println("==========================================================================")
    println("Nhập số đồ vật n và sức chứa W (cách nhau bởi khoảng trắng, ví dụ: 4 10):")
    nw = parse.(Int, split(strip(readline())))
    length(nw) == 2 || throw(ArgumentError("Cần nhập đúng 2 số nguyên n và W"))
    n, W = nw

    w = Int[]
    v = Int[]
    if n > 0
        println("Nhập $n trọng lượng w[1..$n] (cách nhau bởi khoảng trắng, ví dụ: 5 4 6 3):")
        w = parse.(Int, split(strip(readline())))
        println("Nhập $n giá trị v[1..$n] (cách nhau bởi khoảng trắng, ví dụ: 10 40 30 50):")
        v = parse.(Int, split(strip(readline())))
    end
    kiem_tra_dau_vao(n, W, w, v)
    in_ket_qua_chi_tiet("KẾT QUẢ CHẠY DỮ LIỆU NHẬP TỪ BÀN PHÍM", w, v, W; in_bang = true)
end

function minh_hoa_du_lieu_sai()
    println("==========================================================================")
    println("  HÌNH 4.8 (ẢNH A08) - KIỂM TRA INPUT KHÔNG HỢP LỆ (CA T12 / LOI01)")
    println("==========================================================================")
    cac_ca_loi = [
        ("Vi phạm 1: Sức chứa túi âm (W = -5 < 0)", 1, -5, [2], [3]),
        ("Vi phạm 2: Hai mảng w và v lệch độ dài với n", 2, 5, [2, 3], [10]),
        ("Vi phạm 3: Trọng lượng không nguyên dương (w[1] = 0 <= 0)", 1, 5, [0], [10]),
        ("Vi phạm 4: Giá trị đồ vật âm (v[1] = -10 < 0)", 1, 5, [2], [-10])
    ]
    for (mo_ta, n_err, W_err, w_err, v_err) in cac_ca_loi
        println("\n- Thử nghiệm: $mo_ta")
        println("  Input: n = $n_err, W = $W_err, w = $w_err, v = $v_err")
        try
            giai_bai(n_err, W_err, w_err, v_err)
            error("LỖI: Không chặn được dữ liệu sai!")
        catch err
            if err isa ArgumentError
                println("  -> ĐÃ TỪ CHỐI DỮ LIỆU (ArgumentError): ", err.msg)
                println("  -> Đánh giá: PASS (Bắt đúng lỗi dự kiến)")
            else
                rethrow()
            end
        end
    end
end

function chay_theo_ca(ca::String)
    if ca == "--ca=1"
        in_ket_qua_chi_tiet("HÌNH 4.1 (ẢNH A01) - VÍ DỤ 1 TRÊN PHIẾU (T01 / VD01)", [5, 4, 6, 3], [10, 40, 30, 50], 10)
    elseif ca == "--ca=2"
        in_ket_qua_chi_tiet("HÌNH 4.2 (ẢNH A02) - VÍ DỤ 2 TRÊN PHIẾU (T02 / VD02)", [3, 4, 5], [4, 5, 6], 8)
    elseif ca == "--ca=3"
        in_ket_qua_chi_tiet("HÌNH 4.3 (ẢNH A03) - CA TỰ THIẾT KẾ 1: TẤT CẢ ĐỒ VẬT VỪA TÚI (T03 / TK01)", [1, 2, 3], [10, 20, 30], 10)
    elseif ca == "--ca=4"
        in_ket_qua_chi_tiet("HÌNH 4.4 (ẢNH A04) - CA TỰ THIẾT KẾ 2: CÙNG TRỌNG LƯỢNG, CHỌN GIÁ TRỊ CAO (T04 / TK02)", [5, 5], [20, 50], 5)
    elseif ca == "--ca=5"
        in_ket_qua_chi_tiet("HÌNH 4.5 (ẢNH A05) - CA BIÊN 1: SỨC CHỨA TÚI W = 0 (T05 / BIEN01 / CA 2 PHIẾU)", [2, 3], [10, 20], 0)
    elseif ca == "--ca=6"
        in_ket_qua_chi_tiet("HÌNH 4.6 (ẢNH A06) - CA BIÊN 2: KHÔNG LẤY MỘT ĐỒ VẬT HAI LẦN (T06 / BIEN02 / CA 4 PHIẾU)", [2], [3], 4)
    elseif ca == "--ca=7"
        in_ket_qua_chi_tiet("HÌNH 4.7 (ẢNH A07) - CA BIÊN 3: MỌI ĐỒ VẬT NẶNG HƠN W (T07 / BIEN03 / CA 3 PHIẾU)", [5], [9], 4)
    elseif ca == "--ca=8"
        minh_hoa_du_lieu_sai()
    else
        throw(ArgumentError("Tham số không hợp lệ: $ca (chọn từ --ca=1 đến --ca=8 hoặc --nhap)"))
    end
end

if "--nhap" in ARGS
    nhap_ban_phim()
elseif any(startswith("--ca="), ARGS)
    ca = only(filter(startswith("--ca="), ARGS))
    chay_theo_ca(ca)
else
    chay_theo_ca("--ca=1")
    println()
    chay_theo_ca("--ca=2")
end

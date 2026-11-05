"""
Module DeTai - Đề tài DT051: Cái túi 0/1 bằng bảng quy hoạch động
Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
Học phần: Cấu trúc Dữ liệu và Giải thuật (INT13185) - Nhóm 03 - PTIT TP.HCM
Căn cứ: Giáo trình INT1306, Chương 4, mục 4.3.2.2; Ví dụ 4.8; Bài 4.3; Bài tập câu 22, 32.
"""
module DeTai

using Printf

export kiem_tra_dau_vao,
       cai_tui_bang,
       truy_vet_do,
       truy_vet,
       kiem_tra_chon,
       giai_bai,
       cai_tui_dp,
       cai_tui_1d,
       liet_ke_vet_can,
       in_bang_dp,
       in_ket_qua_chi_tiet

"""
    kiem_tra_dau_vao(n::Int, W::Int, w::Vector{Int}, v::Vector{Int})
    kiem_tra_dau_vao(w::Vector{Int}, v::Vector{Int}, W::Int)

Kiểm tra hợp đồng đầu vào theo đúng phiếu giao đề tài DT051:
- 0 <= n <= 30, hai mảng w và v cùng độ dài n.
- 0 <= W <= 200 (sức chứa nguyên không âm).
- Mỗi w[i] nguyên dương <= 30 (1 <= w[i] <= 30).
- Mỗi v[i] nguyên không âm <= 100 (0 <= v[i] <= 100).
Nếu vi phạm ném ngoại lệ ArgumentError.
"""
function kiem_tra_dau_vao(n::Int, W::Int, w::Vector{Int}, v::Vector{Int})
    if n < 0 || n > 30
        throw(ArgumentError("Số lượng đồ vật n = $n nằm ngoài miền hợp lệ (yêu cầu 0 <= n <= 30)"))
    end
    if W < 0 || W > 200
        throw(ArgumentError("Sức chứa túi W = $W nằm ngoài miền hợp lệ (yêu cầu 0 <= W <= 200)"))
    end
    if length(w) != n || length(v) != n
        throw(ArgumentError("Độ dài mảng w ($(length(w))) và v ($(length(v))) không khớp với n = $n"))
    end
    for i in 1:n
        if w[i] <= 0 || w[i] > 30
            throw(ArgumentError("Trọng lượng w[$i] = $(w[i]) không hợp lệ (yêu cầu nguyên dương 1 <= w[i] <= 30)"))
        end
        if v[i] < 0 || v[i] > 100
            throw(ArgumentError("Giá trị v[$i] = $(v[i]) không hợp lệ (yêu cầu nguyên không âm 0 <= v[i] <= 100)"))
        end
    end
    return true
end

function kiem_tra_dau_vao(w::Vector{Int}, v::Vector{Int}, W::Int)
    if length(w) != length(v)
        throw(ArgumentError("Độ dài mảng trọng lượng w ($(length(w))) và giá trị v ($(length(v))) không bằng nhau"))
    end
    return kiem_tra_dau_vao(length(w), W, w, v)
end

"""
    cai_tui_bang(w::Vector{Int}, v::Vector{Int}, W::Int)

Lập bảng quy hoạch động f kích thước (n+1) × (W+1).
Hàng i từ 0 đến n (lưu tại f[i+1, j+1]), cột j từ 0 đến W.
Trả về: (f, max_val)
"""
function cai_tui_bang(w::Vector{Int}, v::Vector{Int}, W::Int)
    kiem_tra_dau_vao(w, v, W)
    n = length(w)
    f = zeros(Int, n + 1, W + 1)

    for i in 1:n
        wi = w[i]
        vi = v[i]
        for j in 1:W
            if j < wi
                f[i + 1, j + 1] = f[i, j + 1]
            else
                f[i + 1, j + 1] = max(f[i, j + 1], f[i, j + 1 - wi] + vi)
            end
        end
    end
    return f, f[n + 1, W + 1]
end

"""
    truy_vet(f::Matrix{Int}, n::Int, W::Int, w::Vector{Int}) -> Vector{Int}
    truy_vet_do(f::Matrix{Int}, w::Vector{Int}, W::Int) -> Vector{Int}

Truy vết ngược từ ô cuối f[n, W] về hàng 0 để tìm các ID đồ vật được chọn
theo thứ tự tăng dần (1-based).
"""
function truy_vet(f::Matrix{Int}, n::Int, W::Int, w::Vector{Int})
    selected_items = Int[]
    curr_w = W
    for i in n:-1:1
        if curr_w <= 0
            break
        end
        if f[i + 1, curr_w + 1] != f[i, curr_w + 1]
            push!(selected_items, i)
            curr_w -= w[i]
        end
    end
    return reverse(selected_items)
end

function truy_vet_do(f::Matrix{Int}, w::Vector{Int}, W::Int)
    return truy_vet(f, length(w), W, w)
end

"""
    kiem_tra_chon(chon::Vector{Int}, w::Vector{Int}, v::Vector{Int}, W::Int)

Tự cộng trọng lượng và giá trị các ID được chọn để kiểm chứng độc lập:
- Mỗi ID thuộc 1..n, tăng dần nghiêm ngặt (không lấy một đồ hai lần).
- Tổng trọng lượng <= W.
"""
function kiem_tra_chon(chon::Vector{Int}, w::Vector{Int}, v::Vector{Int}, W::Int)
    n = length(w)
    hop_le_id = all(1 <= id <= n for id in chon) && issorted(chon; lt = <=) && (length(chon) == length(unique(chon)))
    tong_w = isempty(chon) ? 0 : sum(w[i] for i in chon)
    tong_v = isempty(chon) ? 0 : sum(v[i] for i in chon)
    hop_le = hop_le_id && (tong_w <= W)
    return (tong_trong_luong = tong_w, tong_gia_tri = tong_v, hop_le = hop_le)
end

"""
    giai_bai(n::Int, W::Int, w::Vector{Int}, v::Vector{Int})

Hàm thực thi chính theo thiết kế Chương 3: trả về (max_val, selected_items).
"""
function giai_bai(n::Int, W::Int, w::Vector{Int}, v::Vector{Int})
    kiem_tra_dau_vao(n, W, w, v)
    if n == 0 || W == 0
        return (0, Int[])
    end
    f, max_val = cai_tui_bang(w, v, W)
    selected_items = truy_vet(f, n, W, w)
    return (max_val, selected_items)
end

"""
    cai_tui_dp(w::Vector{Int}, v::Vector{Int}, W::Int)

Hàm tổng hợp trả về đầy đủ: (max_val, selected_items, f, tong_trong_luong).
"""
function cai_tui_dp(w::Vector{Int}, v::Vector{Int}, W::Int)
    f, max_val = cai_tui_bang(w, v, W)
    chon = truy_vet_do(f, w, W)
    kt = kiem_tra_chon(chon, w, v, W)
    @assert kt.hop_le && kt.tong_gia_tri == max_val
    return max_val, chon, f, kt.tong_trong_luong
end

"""
    cai_tui_1d(w::Vector{Int}, v::Vector{Int}, W::Int) -> Int

Yêu cầu thêm trên phiếu DT051: Giảm bảng về một mảng O(W), duyệt sức chứa giảm dần
từ W về w[i] để không lấy một đồ vật nhiều lần.
"""
function cai_tui_1d(w::Vector{Int}, v::Vector{Int}, W::Int)
    kiem_tra_dau_vao(w, v, W)
    dp = zeros(Int, W + 1)
    for (wi, vi) in zip(w, v)
        for j in W:-1:wi
            dp[j + 1] = max(dp[j + 1], dp[j - wi + 1] + vi)
        end
    end
    return dp[W + 1]
end

"""
    liet_ke_vet_can(w::Vector{Int}, v::Vector{Int}, W::Int)

Thuật toán vét cạn 2^n tập con (Oracle độc lập) để đối chiếu tính tối ưu.
"""
function liet_ke_vet_can(w::Vector{Int}, v::Vector{Int}, W::Int)
    kiem_tra_dau_vao(w, v, W)
    n = length(w)
    best_val = 0
    best_items = Int[]
    best_weight = 0

    for mask in 0:((1 << n) - 1)
        cur_w = 0
        cur_v = 0
        cur_items = Int[]
        for i in 1:n
            if ((mask >> (i - 1)) & 1) == 1
                cur_w += w[i]
                cur_v += v[i]
                push!(cur_items, i)
            end
        end
        if cur_w <= W && cur_v > best_val
            best_val = cur_v
            best_items = cur_items
            best_weight = cur_w
        end
    end
    return best_val, best_items, best_weight
end

"""
    in_bang_dp(f::Matrix{Int}, n::Int, W::Int)

In bảng quy hoạch động f[0..n, 0..W] để kiểm từng hàng theo yêu cầu phiếu DT051.
"""
function in_bang_dp(f::Matrix{Int}, n::Int, W::Int)
    print(" i\\j |")
    for j in 0:W
        @printf("%4d", j)
    end
    println("\n" * "-"^(6 + 4 * (W + 1)))
    for i in 0:n
        @printf("%3d  |", i)
        for j in 0:W
            @printf("%4d", f[i + 1, j + 1])
        end
        println()
    end
end

"""
    in_ket_qua_chi_tiet(tieu_de::String, w::Vector{Int}, v::Vector{Int}, W::Int; in_bang::Bool=true)

In đầy đủ dữ liệu vào, kết quả chính (giá trị tối ưu, các ID được chọn tăng dần,
tổng trọng lượng) và bảng quy hoạch động theo đúng yêu cầu đầu ra của phiếu DT051.
"""
function in_ket_qua_chi_tiet(tieu_de::String, w::Vector{Int}, v::Vector{Int}, W::Int; in_bang::Bool=true)
    n = length(w)
    println("==========================================================================")
    println("  ", tieu_de)
    println("==========================================================================")
    println("Dữ liệu vào (Input):")
    println("  - Số đồ vật (n)       : $n")
    println("  - Sức chứa túi (W)    : $W")
    println("  - Mảng trọng lượng (w): $w")
    println("  - Mảng giá trị (v)    : $v")

    val, chon, f, tw = cai_tui_dp(w, v, W)
    kt = kiem_tra_chon(chon, w, v, W)

    println("\nKết quả ra (Output):")
    println("  - Giá trị tối ưu f[n, W]        : $val")
    println("  - Các ID được chọn (tăng dần)   : $chon")
    println("  - Tổng trọng lượng các đồ đã chọn: $tw / $W")
    println("  - Kiểm tra độc lập (kiem_tra_chon): ", kt.hop_le ? "HỢP LỆ (ĐÚNG 100%)" : "KHÔNG HỢP LỆ")

    if in_bang && n <= 15 && W <= 25
        println("\nBảng quy hoạch động f[i, j] (kích thước $(n+1) × $(W+1)):")
        in_bang_dp(f, n, W)
    end
    return val, chon, f, tw
end

end # module DeTai

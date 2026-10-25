"""
Module giải bài toán Cái túi 0/1 bằng bảng Quy hoạch động (DT051)
Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
INT13185 - Nhóm 03 - PTIT TP.HCM
"""

def kiem_tra_dau_vao(w: list[int], v: list[int], W: int) -> bool:
    """Kiểm tra hợp đồng đầu vào."""
    if not isinstance(W, int) or W < 0:
        raise ValueError("Sức chứa W phải là số nguyên không âm (W >= 0)")
    if len(w) != len(v):
        raise ValueError("Độ dài mảng trọng lượng w và giá trị v phải bằng nhau")
    if len(w) < 1:
        raise ValueError("Số lượng đồ vật n phải >= 1")
    for i, (wi, vi) in enumerate(zip(w, v)):
        if not isinstance(wi, int) or wi <= 0:
            raise ValueError(f"Trọng lượng w[{i}] = {wi} phải là số nguyên dương")
        if not isinstance(vi, int) or vi <= 0:
            raise ValueError(f"Giá trị v[{i}] = {vi} phải là số nguyên dương")
    return True

def cai_tui_dp(w: list[int], v: list[int], W: int):
    """
    Quy hoạch động giải bài toán Cái túi 0/1.
    Trả về: (gia_tri_max, ds_chon, f, tong_trong_luong)
    """
    kiem_tra_dau_vao(w, v, W)
    n = len(w)
    # f[i][j]: hàng 0..n, cột 0..W
    f = [[0] * (W + 1) for _ in range(n + 1)]

    for i in range(1, n + 1):
        wi = w[i - 1]
        vi = v[i - 1]
        for j in range(W + 1):
            f[i][j] = f[i - 1][j]
            if wi <= j:
                f[i][j] = max(f[i][j], f[i - 1][j - wi] + vi)

    # Truy vết ngược từ f[n][W]
    chon = []
    j = W
    for i in range(n, 0, -1):
        if f[i][j] != f[i - 1][j]:
            chon.append(i)  # ID đồ vật (1-based)
            j -= w[i - 1]

    chon.sort()
    tong_w = sum(w[idx - 1] for idx in chon)
    gia_tri_max = f[n][W]

    return gia_tri_max, chon, f, tong_w

def giai_cai_tui_dp(w, v, W):
    val, items, _, total_w = cai_tui_dp(w, v, W)
    return {"max_value": val, "selected_items": items, "total_weight": total_w}

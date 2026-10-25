"""
Demo thực thi giải thuật Cái túi 0/1 (DT051)
Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
"""
from logic import cai_tui_dp

def main():
    print("=" * 80)
    print("  ĐỒ ÁN CTDL&GT (INT13185) - NHÓM 03 - PTIT TP.HCM")
    print("  ĐỀ TÀI DT051: CÁI TÚI 0/1 BẰNG BẢNG QUY HOẠCH ĐỘNG")
    print("  Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057")
    print("=" * 80 + "\n")

    # Ví dụ 1: Ví dụ 4.8 giáo trình INT1306 (trang in 99)
    print("--- [VÍ DỤ 1: Chuẩn Giáo trình INT1306 Ví dụ 4.8] ---")
    w1 = [5, 4, 6, 3]
    v1 = [10, 40, 30, 50]
    W1 = 10
    print(f"Input: n = 4, W = {W1}")
    print(f"       Trọng lượng w = {w1}")
    print(f"       Giá trị     v = {v1}")

    val1, items1, f1, tw1 = cai_tui_dp(w1, v1, W1)
    print(f"Output: Giá trị lớn nhất = {val1}")
    print(f"        Đồ vật được chọn = {items1} (Vật 2 và Vật 4)")
    print(f"        Tổng trọng lượng = {tw1} / {W1}")
    print("Expected: Giá trị 90, đồ vật [2, 4], trọng lượng 7 <= 10")
    print("Kết luận:", "PASS (Chính xác 100%)" if val1 == 90 and items1 == [2, 4] else "FAIL")

    print("\n--- BẢNG MA TRẬN QUY HOẠCH ĐỘNG f[i, j] (5 x 11) ---")
    header = " i\\j |" + "".join(f"{j:4d}" for j in range(W1 + 1))
    print(header)
    print("-" * len(header))
    for i in range(5):
        row = f"{i:3d}  |" + "".join(f"{f1[i][j]:4d}" for j in range(W1 + 1))
        print(row)

    # Ví dụ 2: Ca biên trên phiếu (w=[2], v=[3], W=4)
    print("\n--- [VÍ DỤ 2: Ca biên trên phiếu - w=[2], v=[3], W=4] ---")
    val2, items2, _, tw2 = cai_tui_dp([2], [3], 4)
    print(f"Input:  n = 1, W = 4, w = [2], v = [3]")
    print(f"Output: Giá trị = {val2}, Đồ vật = {items2}, Trọng lượng = {tw2}")
    print("Expected: Giá trị 3, Đồ vật [1]")
    print("Kết luận:", "PASS (Chính xác 100%)" if val2 == 3 and items2 == [1] else "FAIL")

if __name__ == "__main__":
    main()

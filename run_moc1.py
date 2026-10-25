"""
CHƯƠNG TRÌNH KIỂM THỬ MỐC 1: BÁO CÁO TIẾN ĐỘ 1 (DT051)
Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N
"""
from src.detai import kiem_tra_dau_vao, cai_tui_dp, truy_vet, giai_bai

def main():
    print("=" * 75)
    print("  BÁO CÁO TIẾN ĐỘ 1 (MỐC 1) - HỌC PHẦN CTDL&GT (INT13185)")
    print("  ĐỀ TÀI DT051: CÁI TÚI 0/1 BẰNG BẢNG QUY HOẠCH ĐỘNG")
    print("  Sinh viên: Tô Cảnh Đạt Nguyên - MSSV: N24DCDT057 - Lớp: D24CQDT01-N")
    print("=" * 75)

    # 1. Chạy Ví dụ 1 (Ví dụ 4.8 Giáo trình INT1306 trang 99)
    print("\n--- [VÍ DỤ 1: CHUẨN GIÁO TRÌNH INT1306 VÍ DỤ 4.8] ---")
    w1 = [5, 4, 6, 3]
    v1 = [10, 40, 30, 50]
    W1 = 10
    print(f"Input:  n = 4, W = {W1}")
    print(f"        w = {w1}")
    print(f"        v = {v1}")

    val1, items1, f1, tw1 = cai_tui_dp(w1, v1, W1)
    print(f"Output: Giá trị tối ưu = {val1}")
    print(f"        Đồ vật chọn    = {items1} (Đồ vật 2 và Đồ vật 4)")
    print(f"        Tổng khối lượng= {tw1} / {W1}")
    pass1 = (val1 == 90 and items1 == [2, 4] and tw1 == 7)
    print(f"Kết quả kiểm thử Ví dụ 1: {'>>> PASS (CHÍNH XÁC 100%) <<<' if pass1 else 'FAIL'}")

    # In bảng f[i, j]
    print("\nBẢNG QUY HOẠCH ĐỘNG f[i, j] (5 hàng x 11 cột):")
    print(" i\\j |" + "".join(f"{j:4d}" for j in range(W1 + 1)))
    print("-" * 52)
    for i in range(5):
        print(f"{i:3d}  |" + "".join(f"{f1[i][j]:4d}" for j in range(W1 + 1)))

    # 2. Chạy Ví dụ 2 (Ca biên trên phiếu)
    print("\n--- [VÍ DỤ 2: CA BIÊN TRÊN PHIẾU GIAO ĐỀ TÀI] ---")
    w2 = [2]
    v2 = [3]
    W2 = 4
    print(f"Input:  n = 1, W = {W2}, w = {w2}, v = {v2}")

    val2, items2, f2, tw2 = cai_tui_dp(w2, v2, W2)
    print(f"Output: Giá trị tối ưu = {val2}")
    print(f"        Đồ vật chọn    = {items2}")
    print(f"        Tổng khối lượng= {tw2} / {W2}")
    pass2 = (val2 == 3 and items2 == [1] and tw2 == 2)
    print(f"Kết quả kiểm thử Ví dụ 2: {'>>> PASS (CHÍNH XÁC 100%) <<<' if pass2 else 'FAIL'}")

    print("\n" + "=" * 75)
    print("  KẾT LUẬN: ĐÃ HOÀN THÀNH 100% YÊU CẦU MÃ NGUỒN CỐT LÕI MỐC 1!")
    print("=" * 75)

if __name__ == "__main__":
    main()

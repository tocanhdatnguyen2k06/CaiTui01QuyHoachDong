import pytest
from logic import cai_tui_dp

def test_t01_vi_du_giao_trinh():
    val, items, _, tw = cai_tui_dp([5, 4, 6, 3], [10, 40, 30, 50], 10)
    assert val == 90
    assert items == [2, 4]
    assert tw == 7

def test_t02_vi_du_bien_phieu():
    val, items, _, tw = cai_tui_dp([2], [3], 4)
    assert val == 3
    assert items == [1]
    assert tw == 2

def test_t03_tui_suc_chua_khong():
    val, items, _, tw = cai_tui_dp([5, 4], [10, 20], 0)
    assert val == 0
    assert items == []
    assert tw == 0

def test_t04_moi_vat_qua_nang():
    val, items, _, _ = cai_tui_dp([10, 15], [50, 100], 5)
    assert val == 0
    assert items == []

def test_t05_tat_ca_vat_vua_tui():
    val, items, _, tw = cai_tui_dp([1, 2, 3], [10, 20, 30], 10)
    assert val == 60
    assert items == [1, 2, 3]
    assert tw == 6

def test_t06_chon_vat_gia_tri_cao_hon():
    val, items, _, _ = cai_tui_dp([5, 5], [20, 50], 5)
    assert val == 50
    assert items == [2]

def test_t07_chon_vat_nhe_hon():
    val, items, _, tw = cai_tui_dp([6, 3], [40, 40], 5)
    assert val == 40
    assert items == [2]
    assert tw == 3

def test_t08_bai_tap_3_3_giao_trinh():
    val, items, _, tw = cai_tui_dp([12, 7, 11, 8, 9], [24, 13, 23, 15, 16], 26)
    assert val == 51
    assert items == [2, 3, 4]
    assert tw == 26

def test_t09_mot_vat_dung_bang_w():
    val, items, _, tw = cai_tui_dp([5], [100], 5)
    assert val == 100
    assert items == [1]
    assert tw == 5

def test_t10_bai_tap_4_22_giao_trinh():
    val, items, _, tw = cai_tui_dp([3, 4, 5], [4, 5, 6], 8)
    assert val == 10
    assert items == [1, 3]
    assert tw == 8

def test_t11_bat_bien_tong_trong_luong():
    w = [2, 3, 4, 5, 6]
    v = [3, 4, 5, 8, 9]
    W = 9
    val, items, _, tw = cai_tui_dp(w, v, W)
    assert tw <= W
    assert sum(v[i - 1] for i in items) == val

def test_validator_errors():
    with pytest.raises(ValueError):
        cai_tui_dp([2], [3], -1)  # W < 0
    with pytest.raises(ValueError):
        cai_tui_dp([2, 3], [3], 5)  # len w != len v
    with pytest.raises(ValueError):
        cai_tui_dp([], [], 5)  # rỗng
    with pytest.raises(ValueError):
        cai_tui_dp([0], [10], 5)  # w_i <= 0

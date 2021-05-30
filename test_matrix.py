import unittest
import nm
from nm import Matrix


class TestMatrix(unittest.TestCase):
    def test_shape(self):
        m = Matrix(4, 5)
        assert m.shape() == [4, 5]

    def test_equal(self):
        m = Matrix.zeros((5, 6))
        n = Matrix.zeros((5, 6))
        assert m == n

    def test_get_item(self):
        m = Matrix.ones((7, 8))
        n = m[3:6, 2:7]
        n_gt = Matrix.ones((3, 5))
        assert n.shape() == [3, 5]
        assert n == n_gt

        n = m[3:6]
        n_gt = Matrix.ones((3, 8))
        assert n == n_gt
        pass

    def test_set_item(self):
        m = Matrix.zeros((10, 10))
        m[0:5, 3:5] = Matrix.ones((5, 2))
        assert m[0:5, 3:5] == Matrix.ones((5, 2))
        m[1, 1] = 45454.0
        assert m[1, 1] == 45454.0
        m[3:5] = Matrix.zeros((2, 10))
        assert m[3:5] == Matrix.zeros((2, 10))

    def test_zeros(self):
        m = Matrix.zeros((5, 4))
        assert m.shape() == [5, 4]
        m = Matrix.zeros(9)
        assert m.shape() == [9, 1]

    def test_ones(self):
        m = Matrix.ones((5, 4))
        assert m.shape() == [5, 4]

        m = Matrix.ones(9)
        assert m.shape() == [9, 1]

    def test_eye(self):
        m = Matrix.eye(3)
        m_gt = Matrix.zeros((3, 3))
        m_gt.set(0, 0, 1.0)
        m_gt.set(1, 1, 1.0)
        m_gt.set(2, 2, 1.0)
        assert m == m_gt

    def test_add(self):
        m = Matrix.ones((4, 5))
        n = Matrix(4, 5)
        n.set_all(5.0)
        res = m + n
        res_gt = Matrix(4, 5)
        res_gt.set_all(6.0)
        assert res.shape() == [4, 5]
        assert res == res_gt

    def test_sub(self):
        m = Matrix.ones((4, 5))
        n = Matrix(4, 5)
        n.set_all(5.0)
        res = m - n
        res_gt = Matrix(4, 5)
        res_gt.set_all(-4.0)
        assert res.shape() == [4, 5]
        assert res == res_gt


if __name__ == "__main__":
    unittest.main()

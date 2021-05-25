import unittest
import nm
from nm import Matrix


class TestMatrix(unittest.TestCase):
    def test_shape(self):
        m = Matrix(4, 5)
        assert m.shape() == [4, 5]

    def test_get_item(self):
        pass

    def test_zeros(self):
        m = Matrix.zeros((5, 4))
        assert m.shape() == [5, 4]
        m = Matrix.zeros(9)
        assert m.shape() == [9, 1]

    def test_equal(self):
        m = Matrix.zeros((5, 6))
        n = Matrix.zeros((5, 6))
        assert m == n

    def test_ones(self):
        m = Matrix.ones((5, 4))
        assert m.shape() == [5, 4]

        m = Matrix.ones(9)
        assert m.shape() == [9, 1]

    def test_add(self):
        m = Matrix.ones((4, 5))
        n = Matrix(4, 5)
        n.set_all(5.0)
        res = m + n
        res_gt = Matrix(4, 5)
        res_gt.set_all(6.0)
        assert res.shape() == [4, 5]
        assert res == res_gt


if __name__ == "__main__":
    unittest.main()

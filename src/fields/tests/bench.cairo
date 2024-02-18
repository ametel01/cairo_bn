// test bn::fields::tests::bench::fq01::add ... ok (gas usage est.: 10160)
// test bn::fields::tests::bench::fq01::inv ... ok (gas usage est.: 35270)
// test bn::fields::tests::bench::fq01::mul ... ok (gas usage est.: 49130)
// test bn::fields::tests::bench::fq01::mulu ... ok (gas usage est.: 24140)
// test bn::fields::tests::bench::fq01::rdc ... ok (gas usage est.: 25490)
// test bn::fields::tests::bench::fq01::scale ... ok (gas usage est.: 38430)
// test bn::fields::tests::bench::fq01::sqr ... ok (gas usage est.: 45100)
// test bn::fields::tests::bench::fq01::sqru ... ok (gas usage est.: 20110)
// test bn::fields::tests::bench::fq01::sub ... ok (gas usage est.: 14780)
// test bn::fields::tests::bench::fq02::add ... ok (gas usage est.: 20020)
// test bn::fields::tests::bench::fq02::inv ... ok (gas usage est.: 216850)
// test bn::fields::tests::bench::fq02::mul ... ok (gas usage est.: 168190)
// test bn::fields::tests::bench::fq02::mulu ... ok (gas usage est.: 116010)
// test bn::fields::tests::bench::fq02::mxi ... ok (gas usage est.: 100500)
// test bn::fields::tests::bench::fq02::rdc ... ok (gas usage est.: 52180)
// test bn::fields::tests::bench::fq02::sqr ... ok (gas usage est.: 119260)
// test bn::fields::tests::bench::fq02::sqru ... ok (gas usage est.: 67480)
// test bn::fields::tests::bench::fq02::sub ... ok (gas usage est.: 29560)
// test bn::fields::tests::bench::fq06::add ... ok (gas usage est.: 59460)
// test bn::fields::tests::bench::fq06::inv ... ok (gas usage est.: 2265260)
// test bn::fields::tests::bench::fq06::mul ... ok (gas usage est.: 1326920)
// test bn::fields::tests::bench::fq06::mulu ... ok (gas usage est.: 1169080)
// test bn::fields::tests::bench::fq06::sqr ... ok (gas usage est.: 1059000)
// test bn::fields::tests::bench::fq06::sqru ... ok (gas usage est.: 901060)
// test bn::fields::tests::bench::fq06::sub ... ok (gas usage est.: 88680)
// test bn::fields::tests::bench::fq12::add ... ok (gas usage est.: 118620)
// test bn::fields::tests::bench::fq12::inv ... ok (gas usage est.: 7246300)
// test bn::fields::tests::bench::fq12::mul ... ok (gas usage est.: 4417100)
// test bn::fields::tests::bench::fq12::sqr ... ok (gas usage est.: 3197980)
// test bn::fields::tests::bench::fq12::sub ... ok (gas usage est.: 177360)
// test bn::fields::tests::bench::u512::add ... ok (gas usage est.: 7490)
// test bn::fields::tests::bench::u512::add_bn ... ok (gas usage est.: 14090)
// test bn::fields::tests::bench::u512::mxi ... ok (gas usage est.: 105940)
// test bn::fields::tests::bench::u512::sub ... ok (gas usage est.: 7490)
// test bn::fields::tests::bench::u512::sub_bn ... ok (gas usage est.: 14090)

use bn::traits::{FieldOps, FieldShortcuts, FieldMulShortcuts};
use bn::math::fast_mod as m;
use bn::curve::{U512BnAdd, U512BnSub};
use debug::PrintTrait;

#[inline(always)]
fn u512_one() -> integer::u512 {
    integer::u512 { limb0: 1, limb1: 0, limb2: 0, limb3: 0 }
}

mod u512 {
    use bn::traits::FieldUtils;
    use super::{u512_one, m, PrintTrait, FieldOps, FieldShortcuts, FieldMulShortcuts};
    use integer::u512;
    use bn::curve as c;
    use c::{U512BnAdd, U512BnSub};
    use bn::fields::{fq, Fq, FqMulShort};

    #[test]
    #[available_gas(2000000)]
    fn add_bn() {
        u512_one() + u512_one();
    }

    #[test]
    #[available_gas(2000000)]
    fn sub_bn() {
        u512_one() - u512_one();
    }

    #[test]
    #[available_gas(2000000)]
    fn add() {
        c::u512_add_overflow(u512_one(), u512_one());
    }

    #[test]
    #[available_gas(2000000)]
    fn sub() {
        c::u512_sub_overflow(u512_one(), u512_one());
    }

    #[test]
    #[available_gas(2000000)]
    fn mxi() {
        c::mul_by_xi((u512_one(), u512_one()), c::u512_overflow_precompute_add());
    }
}

mod fq01 {
    use bn::traits::FieldUtils;
    use super::{u512_one, m, PrintTrait, FieldOps, FieldShortcuts, FieldMulShortcuts};
    use integer::u512;
    use bn::curve::{U512BnAdd, U512BnSub};
    use bn::fields::{fq, Fq, FqMulShort};
    #[test]
    #[available_gas(2000000)]
    fn add() {
        let a = fq(645);
        let b = fq(45);
        a + b;
    }

    #[test]
    #[available_gas(2000000)]
    fn sub() {
        let a = fq(645);
        let b = fq(45);
        a - b;
    }

    #[test]
    #[available_gas(2000000)]
    fn mul() {
        let a = fq(645);
        let b = fq(45);
        a * b;
    }


    #[test]
    #[available_gas(2000000)]
    fn scale() {
        let a = fq(645);
        let b = fq(45);
        a.scale(b.c0.low);
    }

    #[test]
    #[available_gas(2000000)]
    fn mulu() {
        let a = fq(645);
        let b = fq(45);
        a.u_mul(b);
    }

    #[test]
    #[available_gas(2000000)]
    fn rdc() {
        let _: Fq = u512_one().to_fq();
    }

    #[test]
    #[available_gas(2000000)]
    fn sqr() {
        let a = fq(645);
        a.sqr();
    }

    #[test]
    #[available_gas(2000000)]
    fn sqru() {
        let a = fq(645);
        a.u_sqr();
    }

    #[test]
    #[available_gas(2000000)]
    fn inv() {
        let a = fq(645);
        a.inv();
    }
}

mod fq02 {
    use bn::traits::FieldUtils;
    use bn::curve as c;
    use super::{u512_one, m, PrintTrait, FieldOps, FieldShortcuts, FieldMulShortcuts};
    use integer::u512;
    use bn::fields::{fq2, Fq2};
    #[test]
    #[available_gas(2000000)]
    fn add() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a + b;
    }

    #[test]
    #[available_gas(2000000)]
    fn sub() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a - b;
    }

    #[test]
    #[available_gas(2000000)]
    fn mul() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a * b;
    }

    #[test]
    #[available_gas(2000000)]
    fn mulu() {
        let a = fq2(34, 645);
        let b = fq2(25, 45);
        a.u_mul(b);
    }

    #[test]
    #[available_gas(2000000)]
    fn mxi() {
        let a = fq2(34, 645);
        a.mul_by_nonresidue();
    }

    #[test]
    #[available_gas(2000000)]
    fn rdc() {
        let _: Fq2 = (u512_one(), u512_one()).to_fq();
    }

    #[test]
    #[available_gas(2000000)]
    fn sqr() {
        let a = fq2(34, 645);
        a.sqr();
    }

    #[test]
    #[available_gas(2000000)]
    fn sqru() {
        let a = fq2(34, 645);
        a.u_sqr();
    }

    #[test]
    #[available_gas(2000000)]
    fn inv() {
        let a = fq2(34, 645);
        a.inv();
    }
}

mod fq06 {
    use super::{u512_one, m, PrintTrait, FieldOps, FieldShortcuts, FieldMulShortcuts};
    use integer::u512;
    use bn::fields::{fq6, Fq6};
    #[test]
    #[available_gas(20000000)]
    fn add() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a + b;
    }

    #[test]
    #[available_gas(20000000)]
    fn sub() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a - b;
    }

    #[test]
    #[available_gas(20000000)]
    fn mul() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a * b;
    }

    #[test]
    #[available_gas(20000000)]
    fn mulu() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        let b = fq6(25, 45, 11, 43, 86, 101);
        a.u_mul(b);
    }

    #[test]
    #[available_gas(20000000)]
    fn sqr() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        a.sqr();
    }

    #[test]
    #[available_gas(2000000)]
    fn sqru() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        a.u_sqr();
    }

    #[test]
    #[available_gas(20000000)]
    fn inv() {
        let a = fq6(34, 645, 20, 55, 140, 105);
        a.inv();
    }
}

mod fq12 {
    use super::{u512_one, m, PrintTrait, FieldOps, FieldShortcuts, FieldMulShortcuts};
    use integer::u512;
    use bn::fields::{fq12, fq6, Fq12};
    #[test]
    #[available_gas(20000000)]
    fn add() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        let b = fq12(25, 45, 11, 43, 86, 101, 1, 1, 1, 1, 1, 1);
        a + b;
    }

    #[test]
    #[available_gas(20000000)]
    fn sub() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        let b = fq12(25, 45, 11, 43, 86, 101, 1, 1, 1, 1, 1, 1);
        a - b;
    }

    #[test]
    #[available_gas(20000000)]
    fn mul() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        let b = fq12(25, 45, 11, 43, 86, 101, 1, 1, 1, 1, 1, 1);
        a * b;
    }

    #[test]
    #[available_gas(20000000)]
    fn sqr() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        a.sqr();
    }

    #[test]
    #[available_gas(30000000)]
    fn inv() {
        let a = fq12(34, 645, 31, 55, 140, 105, 2, 2, 2, 2, 2, 2);
        a.inv();
    }
}


// test bn::math::fast_mod_tests::bench_plain::add ... ok (gas usage est.: 6830)
// test bn::math::fast_mod_tests::bench_plain::div ... ok (gas usage est.: 11450)
// test bn::math::fast_mod_tests::bench_plain::mul ... ok (gas usage est.: 21190)
// test bn::math::fast_mod_tests::bench_plain::rem ... ok (gas usage est.: 11450)
// test bn::math::fast_mod_tests::bench_plain::sub ... ok (gas usage est.: 6830)
// test bn::math::fast_mod_tests::bench::add ... ok (gas usage est.: 13870)
// test bn::math::fast_mod_tests::bench::add_u ... ok (gas usage est.: 3720)
// test bn::math::fast_mod_tests::bench::div ... ok (gas usage est.: 86000)
// test bn::math::fast_mod_tests::bench::div_u ... ok (gas usage est.: 62310)
// test bn::math::fast_mod_tests::bench::mul ... ok (gas usage est.: 52130)
// test bn::math::fast_mod_tests::bench::mul_u ... ok (gas usage est.: 24940)
// test bn::math::fast_mod_tests::bench::scl ... ok (gas usage est.: 40430)
// test bn::math::fast_mod_tests::bench::scl_u ... ok (gas usage est.: 10040)
// test bn::math::fast_mod_tests::bench::sqr ... ok (gas usage est.: 47900)
// test bn::math::fast_mod_tests::bench::sqr_u ... ok (gas usage est.: 20710)
// test bn::math::fast_mod_tests::bench::sub ... ok (gas usage est.: 15710)
// test bn::math::fast_mod_tests::bench::u512_add ... ok (gas usage est.: 7490)
// test bn::math::fast_mod_tests::bench::u512_pad ... ok (gas usage est.: 2530)
// test bn::math::fast_mod_tests::bench::u512_sub ... ok (gas usage est.: 7490)
// test bn::math::fast_mod_tests::bench::u512_sub_pad ... ok (gas usage est.: 10820)

use core::option::OptionTrait;
use core::traits::TryInto;
use bn::fast_mod as f;
use f::{u512, u512Add, u512Sub};
use bn::curve::FIELD;
use debug::PrintTrait;

const a: u256 = 9099547013904003590785796930435194473319680151794113978918064868415326638035;
const b: u256 = 8021715850804026033197027745655159931503181100513576347155970296011118125764;

#[inline(always)]
fn mu512(limb0: u128, limb1: u128, limb2: u128, limb3: u128) -> u512 {
    u512 { limb0, limb1, limb2, limb3 }
}

mod bench {
    use super::mu512;
    use bn::fast_mod as f;
    use f::{u512, u512Add, u512Sub};

    use super::{a, b, FIELD};
    #[test]
    #[available_gas(1000000)]
    fn add() {
        f::add(a, b, FIELD);
    }

    #[test]
    #[available_gas(1000000)]
    fn sub() {
        f::sub(a, b, FIELD);
    }

    #[test]
    #[available_gas(1000000)]
    fn mul() {
        f::mul(a, b, FIELD);
    }

    #[test]
    #[available_gas(1000000)]
    fn scl() {
        f::scl(a, b.low, FIELD.try_into().unwrap());
    }

    #[test]
    #[available_gas(1000000)]
    fn sqr() {
        f::sqr_nz(a, FIELD.try_into().unwrap());
    }

    #[test]
    #[available_gas(100000000)]
    fn div() {
        f::div(a, b, FIELD);
    }

    #[test]
    #[available_gas(1000000)]
    fn add_u() {
        f::add_u(a, b);
    }

    #[test]
    #[available_gas(1000000)]
    fn mul_u() {
        f::mul_u(a, b);
    }

    #[test]
    #[available_gas(1000000)]
    fn scl_u() {
        f::scl_u(a, b.low);
    }

    #[test]
    #[available_gas(1000000)]
    fn sqr_u() {
        f::sqr_u(a);
    }

    #[test]
    #[available_gas(100000000)]
    fn div_u() {
        f::div_u(a, b, FIELD.try_into().unwrap());
    }

    #[test]
    #[available_gas(100000000)]
    fn u512_add() {
        mu512(a.low, a.high, b.low, b.high) + mu512(b.low, b.high, a.low, a.high);
    }

    #[test]
    #[available_gas(100000000)]
    fn u512_pad() {
        f::u512_pad(mu512(a.low, a.high, b.low, b.high), 5);
    }

    #[test]
    #[available_gas(100000000)]
    fn u512_sub() {
        mu512(b.low, b.high, a.low, a.high) - mu512(a.low, a.high, b.low, b.high);
    }

    #[test]
    #[available_gas(100000000)]
    fn u512_sub_pad() {
        f::u512_sub_pad(
            mu512(a.low, a.high, b.low, b.high), mu512(a.low, a.high, b.low, b.high), b
        );
    }
}

mod bench_plain {
    use core::traits::TryInto;
    use super::{a, b, FIELD};
    #[test]
    #[available_gas(1000000)]
    fn add() {
        a + b;
    }

    #[test]
    #[available_gas(1000000)]
    fn sub() {
        a - b;
    }

    #[test]
    #[available_gas(1000000)]
    fn mul() {
        7_u256 * 909954701390400359078579693043519447331968015179411397891806486841532663803;
    }

    #[test]
    #[available_gas(100000000)]
    fn div() {
        a / b;
    }

    #[test]
    #[available_gas(100000000)]
    fn rem() {
        a % b;
    }
}

#[test]
#[available_gas(100000000)]
fn test_all_mod_ops() {
    let add = f::add(a, b, FIELD);
    assert(
        add == 17121262864708029623982824676090354404822861252307690326074035164426444763799,
        'incorrect add'
    );
    let sub = f::sub(a, b, FIELD);
    assert(
        sub == 1077831163099977557588769184780034541816499051280537631762094572404208512271,
        'incorrect sub'
    );
    let mul = f::mul(a, b, FIELD);
    assert(
        mul == 6561477752769399547014183440960600095569924911855714080305417693732453755033,
        'incorrect mul'
    );
    let div = f::div(a, b, FIELD);
    assert(
        div == 12819640619688655488085323601008678463608009668414428319642291645922931558321,
        'incorrect div'
    );
    let sqr_mul = f::mul(a, a, FIELD);
    let sqr = f::sqr_nz(a, FIELD.try_into().unwrap());
    assert(sqr == sqr_mul, 'incorrect square');

    let scl_mul = f::mul(a, u256 { high: 0, low: b.low }, FIELD);
    let scl = f::scl(a, b.low, FIELD.try_into().unwrap());
    assert(scl == scl_mul, 'incorrect square');

    assert(
        mu512(0xffffffffffffffffffffffffffffffff, 1, 2, 3)
            + mu512(4, 5, 6, 7) == mu512(3, 7, 8, 10),
        'incorrect u512 add'
    );
    assert(mu512(4, 5, 6, 7) - mu512(0, 1, 2, 3) == mu512(4, 4, 4, 4), 'incorrect u512 sub');
    assert(
        mu512(4, 5, 6, 7) - mu512(5, 1, 2, 3) == mu512(0xffffffffffffffffffffffffffffffff, 3, 4, 4),
        'incorrect u512 sub'
    );
    assert(
        f::u512_sub_pad(
            mu512(4, 5, 6, 2), mu512(5, 1, 2, 3), u256 { low: 0, high: 5 }
        ) == mu512(0xffffffffffffffffffffffffffffffff, 3, 4, 4),
        'incorrect u512 sub'
    );
// assert(mu512(4, 5, 6, 7) - mu512(5, 1, 2, 3) == mu512(4, 4, 4, 4), 'incorrect u512 sub');
}
// #[test]
// #[available_gas(2000000)]
// fn experiments() {
//     println!("{}", integer::u8_wrapping_add(200, 100));
//     println!("{}", integer::u8_wrapping_sub(90, 100));
// }



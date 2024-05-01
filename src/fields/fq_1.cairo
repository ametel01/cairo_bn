use bn::curve::{FIELD, get_field_nz, add, sub, mul, scl, sqr, div, neg, inv};
use bn::curve::{add_u, sub_u, mul_u, sqr_u, scl_u, u512_reduce, u512_add_u256, u512_sub_u256};
use integer::u512;
use bn::fields::fq_generics::{TFqAdd, TFqSub, TFqMul, TFqDiv, TFqNeg, TFqPartialEq,};
use bn::traits::{FieldUtils, FieldOps, FieldShortcuts, FieldMulShortcuts};
use debug::PrintTrait;

#[derive(Copy, Drop, Serde, Debug)]
struct Fq {
    c0: u256
}

fn fq(c0: u256) -> Fq {
    Fq { c0 }
}

impl FqIntoU512Tuple of Into<Fq, u512> {
    fn into(self: Fq) -> u512 {
        u512 { limb0: self.c0.low, limb1: self.c0.high, limb2: 0, limb3: 0, }
    }
}

impl FqShort of FieldShortcuts<Fq> {
    fn u_add(self: Fq, rhs: Fq) -> Fq {
        // Operation without modding can only be done like 4 times
        Fq { c0: add_u(self.c0, rhs.c0), }
    }


    fn u_sub(self: Fq, rhs: Fq) -> Fq {
        Fq { c0: sub_u(self.c0, rhs.c0), }
    }


    fn fix_mod(self: Fq) -> Fq {
        let (_q, c0, _) = integer::u256_safe_divmod(self.c0, get_field_nz());
        Fq { c0 }
    }
}

impl FqMulShort of FieldMulShortcuts<Fq, u512> {
    fn u_mul(self: Fq, rhs: Fq) -> u512 {
        mul_u(self.c0, rhs.c0)
    }


    fn u512_add_fq(self: u512, rhs: Fq) -> u512 {
        u512_add_u256(self, rhs.c0)
    }


    fn u512_sub_fq(self: u512, rhs: Fq) -> u512 {
        u512_sub_u256(self, rhs.c0)
    }


    fn u_sqr(self: Fq) -> u512 {
        sqr_u(self.c0)
    }


    fn to_fq(self: u512, field_nz: NonZero<u256>) -> Fq {
        fq(u512_reduce(self, field_nz))
    }
}

impl FqUtils of FieldUtils<Fq, u128> {
    fn one() -> Fq {
        fq(1)
    }


    fn zero() -> Fq {
        fq(0)
    }


    fn scale(self: Fq, by: u128) -> Fq {
        Fq { c0: scl(self.c0, by) }
    }


    fn mul_by_nonresidue(self: Fq,) -> Fq {
        if self.c0 == 0 {
            self
        } else {
            -self
        }
    }


    fn conjugate(self: Fq) -> Fq {
        assert(false, 'no_impl: fq conjugate');
        FieldUtils::zero()
    }


    fn frobenius_map(self: Fq, power: usize) -> Fq {
        assert(false, 'no_impl: fq frobenius_map');
        fq(0)
    }
}

impl FqOps of FieldOps<Fq> {
    fn add(self: Fq, rhs: Fq) -> Fq {
        fq(add(self.c0, rhs.c0))
    }


    fn sub(self: Fq, rhs: Fq) -> Fq {
        fq(sub(self.c0, rhs.c0))
    }


    fn mul(self: Fq, rhs: Fq) -> Fq {
        fq(mul(self.c0, rhs.c0))
    }


    fn div(self: Fq, rhs: Fq) -> Fq {
        fq(div(self.c0, rhs.c0))
    }


    fn neg(self: Fq) -> Fq {
        fq(neg(self.c0))
    }


    fn eq(lhs: @Fq, rhs: @Fq) -> bool {
        *lhs.c0 == *rhs.c0
    }


    fn sqr(self: Fq) -> Fq {
        fq(sqr(self.c0))
    }


    fn inv(self: Fq, field_nz: NonZero<u256>) -> Fq {
        fq(inv(self.c0))
    }
}

impl FqIntoU256 of Into<Fq, u256> {
    fn into(self: Fq) -> u256 {
        self.c0
    }
}
impl U256IntoFq of Into<u256, Fq> {
    fn into(self: u256) -> Fq {
        fq(self)
    }
}
impl Felt252IntoFq of Into<felt252, Fq> {
    fn into(self: felt252) -> Fq {
        fq(self.into())
    }
}

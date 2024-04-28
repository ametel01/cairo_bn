use bn::fields::fq_12_exponentiation::PairingExponentiationTrait;
use bn::traits::FieldOps;
use bn::curve::groups::ECOperations;
use bn::g::{Affine, AffineG1Impl, AffineG2Impl, g1, g2, AffineG1, AffineG2,};
use bn::fields::{Fq, Fq2, print::{FqDisplay, Fq12Display}};
use bn::fields::{fq12, Fq12, Fq12Utils, Fq12Exponentiation};
use bn::curve::pairing;
use pairing::optimal_ate::{single_ate_pairing, ate_miller_loop};
use pairing::optimal_ate_impls::{SingleMillerPrecompute, SingleMillerSteps, PPrecompute};
use bn::groth16::utils::{process_input_constraints};

struct Groth16MillerG1 { // Points in G1
    pi_a: AffineG1,
    pi_b: AffineG1,
    k: AffineG1,
}
struct Groth16MillerG2 { // Points in G2
    gamma: AffineG2,
    delta: AffineG2,
    pi_c: AffineG2,
}

module swap_account::Math {

    const U64_MAX:u64 = 18446744073709551615;
    const U128_MAX:u128 = 340282366920938463463374607431768211455;

    /// u64::MAX
    public fun u64_max(): u64 {
        U64_MAX
    }

    /// u128::MAX
    public fun u128_max(): u128 {
        U128_MAX
    }

    /// babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    public fun sqrt(y: u128): u64 {
        if (y < 4) {
            if (y == 0) {
                0u64
            } else {
                1u64
            }
        } else {
            let z = y;
            let x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            };
            (z as u64)
        }
    }

    /// calculate the `y` pow of `x`.
    public fun pow(x: u64, y: u64): u128 {
        let result = 1u128;
        let z = y;
        let u = (x as u128);
        while (z > 0) {
            if (z % 2 == 1) {
                result = (u * result as u128);
            };
            u = (u * u as u128);
            z = z / 2;
        };
        result
    }

    /// https://medium.com/coinmonks/math-in-solidity-part-3-percents-and-proportions-4db014e080b1
    /// calculate x * y / z with as little loss of precision as possible and avoid overflow
    public fun mul_div(x: u128, y: u128, z: u128): u128 {
        if (y == z) {
            return x
        };
        if (x == z) {
            return y
        };
        let a = x / z;
        let b = x % z;
        //x = a * z + b;
        let c = y / z;
        let d = y % z;
        //y = c * z + d;
        a * c * z + a * d + b * c + b * d / z
    }

    /// Return the smallest of two numbers.
    public fun min(a: u128, b: u128): u128 {
        if (a < b) a else b
    }
}
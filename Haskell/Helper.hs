module Helper where

import Control.Monad (filterM)
import Data.Char (digitToInt, intToDigit, isAlphaNum, ord)
import Data.Function (on)
import Data.List (sort, sortBy)
import Data.List.Split (wordsBy)
import qualified Data.Numbers.Primes as Primes
import Numeric (showIntAtBase)

-- infinite list of fibonacci numbers
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

-- infinite list of prime numbers using the sieve of Eratosthenes
-- primes = sieve [2..] where sieve (x:xs) = x : sieve [p | p <- xs, mod p x /= 0]
primes = Primes.primes

-- true iff the number p is a prime number
-- isPrime p = if p < 2 then False else (last $ takeWhile (<=p) primes) == p
isPrime = Primes.isPrime

-- list of primefactors of a number n (including duplicates)
primefactors 1 = []
primefactors n = h : primefactors (div n h) where h = head $ filter (\p -> mod n p == 0) primes

-- true iff the number n is a palindrome
isPalindrome n = show n == reverse (show n)

-- true iff all numbers divide n
divBy n [] = True
divBy n (x:xs) = mod n x == 0 && divBy n xs

-- (proper-)divisors of a number n
divisors n = [d | d <- [1..n], mod n d == 0]
properdivisors n = filter ((==0) . mod n) [1..div n 2]

-- infinite list of triangle numbers
trianglenumbers = [sum [1..n] | n <- [1..]]

-- true iff n is a triangle number
isTriangleNumber n = n == (last $ takeWhile (<=n) trianglenumbers)

-- collatz sequence starting with n
collatz 1 = [1]
collatz n | even n    = n : collatz (div n 2)
          | otherwise = n : collatz (3*n + 1)

-- faculty of a number n
fac n = product [1..n]

-- binominal of n over k
binominal n k = fac n `div` (fac k * fac (n-k))

-- retains only every nth element of a list
select n [] = []
select n xs = head xs : (select n $ drop n xs)

-- list of digits of a number n
digits n = [digitToInt d | d <- show n]

-- splits a String at the delimiter ','
split s = map (filter isAlphaNum) $ wordsBy (==',') s

-- index of the maximum in a list
indexOfMax list = fst . last . sortBy (compare `on` snd) $ zip [1..] list

-- true iff the number n is pandigital regarding the specified digits
isPandigital digits n = (sort $ show n) == (sort $ concatMap show digits)

-- true iff the number n is pandigital, i.e. containing the digits [1..length $ show n] exactly once each
isGenericPandigital n = (sort $ show n) == concatMap show [1..length $ show n]

-- list of rotations of a number n
rotations n = map read [drop i s ++ take i s | i <- [0..length s - 1]] where s = show n

-- true iff n is a circular prime, i.e. all of its rotations are prime
isCircularPrime n = all isPrime (rotations n)

-- converts an Integer n to a string in binary representation
toBinary n = showIntAtBase 2 intToDigit n ""

-- true iff the value x is an Integer
isInt x = x == fromInteger (round x)

-- position of the uppercase letter in the alphabet
posAlphabet c = toInteger $ ord c - ord 'A' + 1

-- infinite list of pentagonal numbers
pentagonnumbers = map (\n -> n*(3*n-1) `div` 2) [1..]

-- true iff n is a pentagonal number
isPentagonNumber n = n == (last $ takeWhile (<=n) pentagonnumbers)

-- powerset of a set
powerset = filterM (const [True, False])
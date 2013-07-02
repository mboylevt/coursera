#!/usr/bin/env node
var fs = require('fs');

// Determine whether or not a number is prime based off of dynamic array
//
// possiblePrime: number we are testing to determine if prime
// primes: array of known primes numbers up to this point
// 
// Returns: true if number is prime, false if number is not prime 
var prime = function(possiblePrime,  primes)
{
	var primeTest = 0;
	// For all elements of the known primes array, determine if posssible prime is a divisor  If not, it's prime.
	for(primeTest = 0; primeTest < primes.length; primeTest++)
	{
		if (!(possiblePrime == primes[primeTest] 
			|| possiblePrime % primes[primeTest]))
		{
			return false;
		}
	}
	primes.push(possiblePrime);
	return true;
};

// Sieve of Eratosthenes redux from some python I wrote for my attempts at Project Euler :)
// Dynamically generates an array of prime numbers, stopping when the desired capacity is reached
//
// n: number of primes to find
//
// Returns: array containing n primes
var sieve = function(n)
{
	var primes = [];
	primes.push(2);
	var i = 3;
	var p = 1;
	while (1)
	{
		if (prime(i,primes))
		{
			p++;
			if(p == n)
			{
				return primes;
			}
		}
		i++;
	}
};

// 'Main'
outfile = 'primes.txt';
fs.writeFileSync(outfile, sieve(100));

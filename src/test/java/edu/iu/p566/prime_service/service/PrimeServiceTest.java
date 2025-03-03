package edu.iu.p566.prime_service.service;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PrimeServiceTest {

    PrimeService primeService = new PrimeService();
    @Test
    void _45IsNotPrime() {
        int n=45;
        boolean expected = false;
        boolean actual = primeService.isPrime(n);
        assertEquals(expected, actual);
    }
    @Test
    void _1000003IsPrime() {
        int n=1000003;
        boolean expected = true;
        boolean actual = primeService.isPrime(n);
        assertEquals(expected, actual);
    }
    @Test
    void _100000008IsNotPrime() {
        int n=100000008;
        boolean expected = false;
        boolean actual = primeService.isPrime(n);
        assertEquals(expected, actual);
    }
}
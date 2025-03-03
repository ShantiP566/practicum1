package edu.iu.p566.prime_service.controller;

import edu.iu.p566.prime_service.service.IPrimeService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@RestController
@RequestMapping("/primes")
public class PrimeController {
    IPrimeService primeService;
    public PrimeController(IPrimeService primeService) {
        this.primeService = primeService;
    }

    @GetMapping("/{n}")
    public boolean isPrime(@PathVariable int n) {
        return primeService.isPrime(n);
    }
}

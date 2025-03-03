package edu.iu.p566.prime_service.service;

import edu.iu.p566.prime_service.model.Customer;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@Service
public interface IAuthenticationService {
    Customer Register(Customer customer) throws IOException;
    boolean Login(String username,String password) throws IOException;
}

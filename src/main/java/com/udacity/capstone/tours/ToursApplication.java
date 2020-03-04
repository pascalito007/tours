package com.udacity.capstone.tours;

import net.bytebuddy.implementation.bytecode.Throw;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ToursApplication {

	public static void main(String[] args) {
		SpringApplication.run(ToursApplication.class, args);
	}

}

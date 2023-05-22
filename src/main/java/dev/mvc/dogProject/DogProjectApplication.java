package dev.mvc.dogProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"dev.mvc"})
public class DogProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(DogProjectApplication.class, args);
	}

}

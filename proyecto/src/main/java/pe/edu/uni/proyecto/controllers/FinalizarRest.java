package pe.edu.uni.proyecto.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import pe.edu.uni.proyecto.dto.FinalizarDto;
import pe.edu.uni.proyecto.service.FinalizarService;

@RestController
@RequestMapping("/finalizar")
public class FinalizarRest {
	
	@Autowired
	private FinalizarService finalizarService;
	
	@PostMapping()
	public ResponseEntity<?> finalizarProg(@RequestBody FinalizarDto bean) {
		try {
			bean = finalizarService.finalizarProgramacion(bean);
			return ResponseEntity.status(HttpStatus.CREATED).body(bean);
		} catch (Exception e) {
			// Manejo de excepción y respuesta con error 500
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body("Error al registrar la programacion: " + e.getMessage());
		}
	}
}
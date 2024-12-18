package pe.edu.uni.proyecto.service;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import pe.edu.uni.proyecto.dto.ReparacionDto;

@Service
public class ReparacionService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	public List<Map<String, Object>> consultaTodosLasReparaciones() {
	    String sql = """
	        select id_reparacion, id_empleado, id_incidente, id_taller, CONVERT(VARCHAR, fecha_reparacion, 103) as fecha_reparacion,calificacion,costo,detalle
            from REPARACION
	    """;
	    List<Map<String, Object>> lista;
	    lista = jdbcTemplate.queryForList(sql); 
	    return lista;
	}
	

	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public void reparacion(ReparacionDto bean) {
			// validaciones
			validarIncidente(bean.getIdIncidente());
			validarEmpleado(bean.getIdEmpleado());
			validarTaller(bean.getIdTaller());
			validarCalificacion(bean.getCalificacion());
			bean.setFechaReparacion(bean.getFechaReparacion());
			validarIngresoFecha(bean.getIdIncidente(), bean.getFechaReparacion());
			validarCosto(bean.getCosto());
			// registro
			registrarReparacion(bean.getIdEmpleado(), bean.getIdIncidente(), 
					bean.getIdTaller(), bean.getFechaReparacion(),
					bean.getCalificacion(), bean.getCosto(), bean.getDetalle());
			actualizarEstadoCarro(bean.getIdIncidente());
			double calificacionfinal = obtenerCalificacionTaller(bean.getIdTaller());
			actualizarpromediotaller(bean.getIdTaller(),calificacionfinal);
	
			System.out.println("Proceso ok.");
			
	}
	
	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void validarTaller(int idtaller) {
		String sql = """
				select count(1) cont from TALLER where id_taller = ? 
				""";
		int cont = jdbcTemplate.queryForObject(sql, Integer.class, idtaller);
		if (cont == 0) {
			throw new RuntimeException("El taller no se encuentra registrado");
		}	
	}

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void validarIncidente(int idincidente) {
		String sql = """
				select count(1) cont from INCIDENTE where id_incidente = ? 
				""";
		int cont = jdbcTemplate.queryForObject(sql, Integer.class, idincidente);
		if (cont == 0) {
			throw new RuntimeException("El incidente no se encuentra registrado");
		}	
	}

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void validarEmpleado(int idempleado) {
		String sql = """
				select count(1) cont from EMPLEADO where id_empleado = ? 
				""";
		int cont = jdbcTemplate.queryForObject(sql, Integer.class, idempleado);
		if (cont == 0) {
			throw new RuntimeException("El empleado no existe");
		}
		
	}

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void actualizarpromediotaller(int idtaller, double calificacionfinal) {
		String sql = """
				UPDATE TALLER
				SET calificacion = ?
				WHERE id_taller = ? 
				""";
		jdbcTemplate.update(sql, calificacionfinal, idtaller);	
	}

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private double obtenerCalificacionTaller(int idtaller ) {
		String sql = """
				SELECT CAST(AVG(totales.calificacion) AS DECIMAL(10, 1)) AS promedio
				FROM (
				    SELECT t1.calificacion FROM REPARACION t1 WHERE t1.id_taller = ? UNION ALL
				    SELECT t2.calificacion FROM MANTENIMIENTO t2 WHERE t2.id_taller = ?
				) AS totales;
				""";
		double calificacionfinal= jdbcTemplate.queryForObject(sql, double.class, idtaller , idtaller );
		return calificacionfinal;

	}

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void actualizarEstadoCarro(int idincidente) {
		String sql = """
				UPDATE CARRO
				SET id_estado = 1
				WHERE id_carro = (SELECT t2.id_carro FROM INCIDENTE t1
				INNER JOIN PROGRAMACION t2 ON t1.id_programacion = t2.id_programacion
				WHERE t1.id_incidente = ? )
		 		""";
		jdbcTemplate.update(sql, idincidente);
		

	}
	
	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void validarCosto(double costo) {
	    if (costo <= 0) {
	        throw new IllegalArgumentException("El costo debe ser un valor positivo mayor a 0.");
	    }
	}

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void registrarReparacion(int idempleado, int idincidente, int idtaller, String fechareparacion,
			double calificacion, double costo, String detalle) {
		String sql = """
					INSERT INTO REPARACION(id_empleado, id_incidente, id_taller, fecha_reparacion,calificacion,costo,detalle)
				             VALUES (?, ?, ?, ?, ?, ?, ?)
				""";
		jdbcTemplate.update(sql, idempleado, idincidente, idtaller, fechareparacion, calificacion, costo, detalle);

	}

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	private void validarIngresoFecha(int idincidente, String fechareparacion) {
		String sql = """
				SELECT COUNT(1) FROM INCIDENTE t1
				            INNER JOIN PROGRAMACION t2 ON t1.id_programacion = t2.id_programacion
				             WHERE t1.id_incidente = ? and ?  BETWEEN CONVERT(VARCHAR(10), t1.fecha_incidente, 120)
				             AND CONVERT(VARCHAR(10), t2.fecha_fin_programada, 120)
				""";
		int cont = jdbcTemplate.queryForObject(sql, Integer.class, idincidente, fechareparacion);
		if (cont == 0) {
			throw new RuntimeException(
					"La fecha es incorrecta , no se encuentra en el intervalo de fecha correspondiente");
		}
	}

	private void validarCalificacion(double calificacion) {
        if (calificacion < 0 || calificacion > 5) {
            throw new IllegalArgumentException("La calificación debe estar entre 0 y 5.");
        }
    }

	@Transactional(propagation = Propagation.MANDATORY, rollbackFor = Exception.class)
	public String convertirFecha(String fecha) {
		try {
			// Definir los formatos: de entrada (dd/MM/yyyy) y de salida (yyyy-MM-dd)
		    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		    // Parsear la fecha de entrada y formatearla al nuevo formato
		    LocalDate date = LocalDate.parse(fecha, inputFormatter);
		    return date.format(outputFormatter);
		} catch (DateTimeParseException e) {
			throw new RuntimeException("Formato de fecha inválido. Asegúrese de usar el formato dd/MM/yyyy");
		} catch (NullPointerException e) {
       	 throw new RuntimeException("Las fechas no pueden ser nulas.");
       }
	}
}

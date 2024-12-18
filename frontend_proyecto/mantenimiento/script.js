// Espera a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    // Agrega un listener para el evento de envío del formulario
    document.getElementById('mantenimientoForm').addEventListener('submit', function(event) {
        // Previene el comportamiento por defecto del formulario
        event.preventDefault();

        const id = localStorage.getItem('id');
        const id_carro = localStorage.getItem('id_carro');
        console.log(id,id_carro);
        // Captura los valores de los campos del formulario
        const idEmpleado = id;
        const idCarro = id_carro;
        const idTaller = document.getElementById('id_taller').value.trim();
        const calificacion = document.getElementById('calificacion').value.trim();
        const fecha_inicio = document.getElementById('fecha_inicio').value.trim();
        const fecha_salida = document.getElementById('fecha_salida_programada').value.trim();
        const costo = document.getElementById('costo').value.trim();
        const detalle = document.getElementById('detalle').value.trim();
        
        // Validación de datos
        if (idEmpleado === '' || idCarro === '' || idTaller === '' || 
            calificacion === '' || fecha_inicio === '' || 
            fecha_salida === '' || costo === '' || 
            detalle === '') {
            mostrarMensaje('Por favor, complete todos los campos obligatorios.', 'error');
            return;
        }

        // Crea un objeto con los datos a enviar
        const data = {
            idEmpleado: idEmpleado,
            idCarro: idCarro,
            idTaller: idTaller,
            calificacion: calificacion,
            fechaInicio: fecha_inicio,
            fechaSalidaProgramada: fecha_salida,
            costo: costo,
            detalle: detalle,
        };

        // Envía los datos al servidor usando fetch
        fetch('http://localhost:8080/api/mantenimiento/registrar', {
            method: 'POST',
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) {
                return response.json().then(data => {
                    throw new Error(data.message || 'Error en la solicitud');
                });
            }
            return response.json();
        })
        .then(data => {
            mostrarMensaje(data.message || 'Mantenimiento registrado exitosamente.', 'success');
            document.getElementById('mantenimientoForm').reset();
        })
        .catch(error => {
            mostrarMensaje(error.message, 'error');
        });
    });
});

// Función para mostrar mensajes
function mostrarMensaje(mensaje, tipo) {
    const mensajeElement = document.getElementById('error-message');
    const successElement = document.getElementById('success-message');

    // Limpiar mensajes previos
    mensajeElement.style.display = 'none';
    successElement.style.display = 'none';

    if (tipo === 'error') {
        mensajeElement.innerText = mensaje;
        mensajeElement.style.display = 'block';
    } else if (tipo === 'success') {
        successElement.innerText = mensaje;
        successElement.style.display = 'block';
    }
}
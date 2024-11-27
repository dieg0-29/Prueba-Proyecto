// Espera a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    // Agrega un listener para el evento de envío del formulario
    document.getElementById('programacionForm').addEventListener('submit', function(event) {
        // Previene el comportamiento por defecto del formulario
        event.preventDefault();

        // Captura los valores de los campos del formulario
        const id_empleado = document.getElementById('id_empleado').value;
        const id_carro = document.getElementById('id_carro').value;
        const id_ruta = document.getElementById('id_ruta').value;
        const fecha_inicio = document.getElementById('fecha_inicio').value;
        const fecha_salida_programada = document.getElementById('fecha_salida_programada').value;

        // Validación de datos (ejemplo)
        if (id_empleado === '' || id_carro === '' || id_ruta === '') {
            document.getElementById('mensaje').innerText = 'Por favor, complete todos los campos obligatorios.';
            return;
        }

        // Crea un objeto con los datos a enviar
        const data = {
            id_empleado: id_empleado,
            id_carro: id_carro,
            id_ruta: id_ruta,
            fecha_inicio: fecha_inicio,
            fecha_salida_programada: fecha_salida_programada,
        };

        // Envía los datos al servidor usando fetch
        fetch('http://localhost:8080/api/registrar/programar', {
            method: 'POST', // Método de la solicitud
            headers: {
                "Content-Type": "application/json" // Tipo de contenido
            },
            body: JSON.stringify(data) // Convierte el objeto a JSON
        })
        .then(response => {
            // Verifica si la respuesta fue exitosa
            if (!response.ok) {
                // Si la respuesta no es exitosa, lanza un error
                return response.text().then(text => {
                    throw new Error(text || 'Error en la solicitud');
                });
            }
            return response.json(); // Devuelve la respuesta en formato JSON
        })
        .then(data => {
            // Muestra un mensaje de éxito
            document.getElementById('mensaje').innerText = 'Registro exitoso: ' + data.message;
            // Resetea el formulario
            document.getElementById('programacionForm').reset();
        })
        .catch(error => {
            // Maneja errores y muestra un mensaje
            document.getElementById('mensaje').innerText = 'Error: ' + error.message;
        });
        app.use((req, res, next) => {
            res.header('Access-Control-Allow-Origin', 'http://127.0.0.1:5500');
            res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
            next();
        });
    });
});
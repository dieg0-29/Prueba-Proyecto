async function obtenerDatos() {
    const url = 'http://localhost:8080/api/conductor/listar'; // Reemplaza con tu URL de API

    try {
        const response = await fetch(url);

        // Verifica si la respuesta es exitosa (código 200-299)
        if (!response.ok) {
            throw new Error(`Error en la red: ${response.status} ${response.statusText}`);
        }

        // Convierte la respuesta a JSON
        const data = await response.json();

        // Muestra los datos en la tabla
        mostrarDatos(data);

    } catch (error) {
        console.error('Hubo un problema con la petición Fetch:', error);
        alert('Error al cargar los datos.'); // Mensaje de error
    }
}

function mostrarDatos(datos) {
    const tablaBody = document.querySelector('#tablaDatos tbody');
    tablaBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

    // Asumiendo que 'datos' es un array de objetos
    datos.forEach(item => {
        const fila = document.createElement('tr');

        // Crear celdas para cada propiedad del objeto
        fila.innerHTML = `
            <td>${item.Id_ruta}</td>
            <td>${item.Nombre}</td>
            <td>${item.Origen}</td>
            <td>${item.Destino}</td>
            <td>${item.Distancia}</td>
            <td><button class="button" onclick="editarRuta(${item.Id_ruta})">Editar</button></td>
            <td><button class="button" onclick="eliminarRuta(${item.Id_ruta})">Eliminar</button></td>
        `;

        tablaBody.appendChild(fila);
    });
}

async function editarRuta(id, button) {
    const row = button.parentNode.parentNode; // Obtener la fila
    const cells = row.getElementsByTagName("td");

    // Cambiar cada celda (excepto la de ID y los botones) a un input
    for (let i = 1; i < cells.length - 2; i++) { // Excluye la primera celda (ID) y las últimas dos (Editar y Eliminar)
        const cell = cells[i];
        const currentValue = cell.innerHTML;

        const input = document.createElement("input");
        input.type = "text";
        input.value = currentValue;

        cell.innerHTML = ""; // Limpiar el contenido de la celda
        cell.appendChild(input); // Agregar el input
    }

    // Cambiar el botón a "Guardar"
    button.innerHTML = "Guardar";
    button.setAttribute("onclick", `guardarRuta(${id}, this)`);
}

async function guardarRuta(id, button) {
    const row = button.parentNode.parentNode; // Obtener la fila
    const cells = row.getElementsByTagName("td");

    const updatedData = {
        Id_ruta: id,
        Nombre: cells[1].getElementsByTagName("input")[0].value,
        Origen: cells[2].getElementsByTagName("input")[0].value,
        Destino: cells[3].getElementsByTagName("input")[0].value,
        Distancia: cells[4].getElementsByTagName("input")[0].value
    };

    try {
        const response = await fetch(`http://localhost:8080/api/ruta/editar/${Nombre}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updatedData)
        });

        if (!response.ok) {
            throw new Error(`Error en la actualización: ${response.status} ${response.statusText}`);
        }

        // Actualiza la tabla con los nuevos datos
        mostrarDatos([updatedData]);

        // Cambiar el botón de vuelta a "Editar"
        button.innerHTML = "Editar";
        button.setAttribute("onclick", `editarRuta(${id}, this)`);
    } catch (error) {
        console.error('Hubo un problema con la actualización:', error);
        alert('Error al actualizar la ruta.');
    }
}
function eliminarRuta(id) {
    // Lógica para eliminar la ruta
    console.log(`Eliminar ruta con ID: ${id}`);
}

// Llamada a la función para obtener y mostrar los datos
obtenerDatos();

document.getElementById('inicioButton').addEventListener('click', () => {
    window.location.href = 'http://127.0.0.1:5500/frontend_proyecto/paginaprincipal/index.html';
});

document.getElementById('cerrarSesionButton').onclick = function() {
    window.location.href = 'http://127.0.0.1:5500/frontend_proyecto/login/login.html';
};

document.getElementById('nuevoRegistroButton').onclick = function() {
    window.location.href = 'http://127.0.0.1:5500/frontend_proyecto/ruta/ruta.html';
};

const username = localStorage.getItem('username');
if (username) {
    document.getElementById('welcomeMessage').innerText = `Bienvenido, ${username}!`; // Mensaje de bienvenida
}
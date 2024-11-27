const express = require('express');
const cors = require('cors'); // Importa el paquete cors
const app = express();

app.use(cors()); // Permite solicitudes de cualquier origen
app.use(express.json()); // Para manejar solicitudes JSON

// Ruta para manejar la solicitud POST
app.post('/api/registrar/programar', (req, res) => {
    const data = req.body; // Captura los datos enviados
    console.log(data); // Muestra los datos en la consola del servidor
    res.json({ message: 'ok' }); // Respuesta de éxito
});

// Inicia el servidor
const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
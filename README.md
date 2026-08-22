
# Calculadora Smart Contract

Proyecto personal desarrollado con Solidity y [Foundry](https://book.getfoundry.sh/) para crear un contrato inteligente que emula una calculadora básica sobre la blockchain.

La idea principal es demostrar cómo se pueden implementar operaciones matemáticas, almacenamiento de estado, control de acceso y pruebas automatizadas en un contrato inteligente de Ethereum.

## Descripción general

Este contrato mantiene un valor público llamado `resultado` y un administrador llamado `admin`. A partir de ese estado, se pueden ejecutar operaciones matemáticas como suma, resta, multiplicación y división.

La particularidad más importante es que la operación de división está restringida únicamente al `admin`, mientras que las otras operaciones son públicas. Esto permite practicar el uso de modificadores y el patrón de control de acceso en Solidity.

## Qué hace exactamente el proyecto

El contrato permite:

- almacenar un valor inicial de resultado al desplegarse
- ejecutar operaciones matemáticas sobre números enteros `uint256`
- guardar el último resultado en la variable pública `resultado`
- emitir eventos con los parámetros y el resultado de cada operación
- proteger la división para que solo la cuenta administrativa pueda usarla

## Funcionalidades del contrato

| Función | Descripción | Acceso |
|---|---|---|
| `addition` | Suma dos números y devuelve el resultado | Público |
| `substraction` | Resta dos números y devuelve el resultado | Público |
| `multiplier` | Multiplica dos números y devuelve el resultado | Público |
| `division` | Divide dos números y devuelve el resultado | Solo `admin` |

### Constructor

```solidity
constructor(uint256 firstResultado_, address admin_)
```

Este constructor inicializa:

- `resultado = firstResultado_`
- `admin = admin_`

Es decir, al desplegar el contrato se define tanto el valor inicial del cálculo como la dirección autorizada para operar con división.

## Regla de seguridad principal

La operación de división tiene un modificador:

```solidity
modifier onlyadmin() {
    require(msg.sender == admin, "Not allowed");
    _;
}
```

Esto hace que cualquier intento de invocar `division` desde una cuenta distinta al administrador falle con un revert.

## Eventos emitidos

Cada operación emite un evento con los parámetros de entrada y el resultado final:

- `Addition`
- `Substraction`
- `Multiplier`
- `Division`

Esto permite consultar la actividad del contrato desde eventos indexados, sin necesidad de leer el estado completo cada vez.

## Mapa conceptual

```mermaid
flowchart TD
    A[Usuario o administrador] --> B[Contrato Calculadora]
    B --> C[Estado]
    C --> D[resultado: uint256]
    C --> E[admin: address]

    B --> F[addition]
    B --> G[substraction]
    B --> H[multiplier]
    B --> I[division]

    F --> J[Emit Addition]
    G --> K[Emit Substraction]
    H --> L[Emit Multiplier]
    I --> M{msg.sender == admin?}
    M -->|Sí| N[Divide y emite Division]
    M -->|No| O[Revert con "Not allowed"]

    B --> P[Pruebas con Foundry]
    P --> Q[testAddition]
    P --> R[testSubstraction]
    P --> S[testMultiplier]
    P --> T[testCanNotDivideByZero]
    P --> U[testIfNotAdminCallsDivisionReverts]
```

## Objetivos del proyecto

Este proyecto busca practicar y demostrar los siguientes conceptos:

- uso de variables de estado en Solidity
- manejo de eventos
- control de acceso con `require`
- validación de errores y revert
- pruebas unitarias con Foundry
- pruebas fuzzing para comportamiento más robusto

## Requisitos

Para ejecutar este proyecto necesitas tener instalado:

- [Foundry](https://book.getfoundry.sh/)
- Node.js opcional para herramientas externas
- Git para control de versiones

## Cómo ejecutar el proyecto

1. Clonar el repositorio
2. Entrar en la carpeta del proyecto
3. Compilar el contrato:

```bash
forge build
```

4. Ejecutar pruebas:

```bash
forge test
```

5. Formatear el código:

```bash
forge fmt
```

## Cobertura de pruebas

El archivo de pruebas incluye casos para verificar:

- valor inicial del constructor
- suma correcta
- resta correcta
- multiplicación correcta
- overflow en multiplicación
- acceso no autorizado a división
- división ejecutada por el admin
- división por cero
- ejecución de la lógica con datos aleatorios (fuzzing)

## Estado actual del proyecto

El contrato está funcional y las pruebas pasan con Foundry. El proyecto funciona como una base sólida para seguir ampliando la lógica, por ejemplo:

- añadir más operadores matemáticos
- agregar permisos por roles
- incluir historial de operaciones
- hacer que las operaciones también sean administradas por roles específicos

## Limitaciones actuales

- La lógica de acceso se aplica únicamente a la división.
- Las otras operaciones son públicas por diseño.
- La operación de división no maneja un caso especial para `0` manualmente, sino que depende del revert nativo de Solidity.

## Estructura del repositorio

```text
.
├── src/
│   └── Calculadora.sol
├── test/
│   └── CalculadoraTest.t.sol
├── README.md
├── foundry.toml
└── lib/
```

## Recursos útiles

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Documentation](https://docs.soliditylang.org/)

## Licencia

MIT

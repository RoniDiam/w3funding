# W3Funding

W3Funding es un proyecto de Smarts Contracts para crowdfunding en la blockchain. Esto significa que personas/ startups/ empresas pueden publicar su proyecto a realizar en la plataforma, indicando de que se trata el proyecto y cuantos tokens  necesita recaudar y el objetivo es conseguir esos tokens para financiarse.
Por otra parte, el usuario de W3Funding además de aportar tokens a los proyectos que se publiquen, puede tener el token W3G. Este token es de gobernanza y sirve para la toma de decisiones de W3Funding. Haciendo que W3Funding sea una DAO (Decentralized Autonomous Organization).

Consta de:
 - 1 Smart Contract para la gestión de un token ERC20. Que será el token para la recaudación en la plataforma: symbol W3F
 - 1 Smart Contract para la gestión de un token ERC20. Que será el token de gobernanza de la plataforma: symbol W3G
 - 1 Smart Contract que sirva de base (template) para la gestión de cada proyecto de crowfunding (más detalles abajo).
 - 1 Smart Contract que permita crear, en base al template anterior, 1 Smart Contract para cada proyecto que se cree (Factory Pattern), definiendo en su creación: Nombre del proyecto, descripción del proyecto, monto objetivo a recaudar, owner (quien crea el proyecto) y precio del token de gobernanza (W3G) en W3F (es decir, cuántos tokens W3F necesitaré para adquirir un token de gobernanza W3G)

Funcionalidades para el Smart Contract template:
 - Función que permita obtener el monto objetivo a recaudar del proyecto
 - Función que permita comprar tokens W3F (a razón de 1 W3F = 0.01 ETH)
 - Función que permita cambiar tokens W3F por ETH (por si alguien compra más tokens de los que quería donar; con la misma tasa de cambio anterior)
 - Función que permita aportar tokens W3F al proyecto
 - Función que permita ver el total recaudado
 - Función que permita saber si el objetivo se cumplió (si monto objetivo es mayor o igual al total recaudado devuelve true; sino devuelve false)
 - Función que permita obtener 1 token de gobernanza (W3G) a cambio de X W3F (en función de lo que se defina a la hora de crear el Smart Contract de cada proyecto); cada address podrá adquirir como máximo 1 solo W3G
 - Función que permita crear una propuesta (con un título, una descripción y una fecha límite, restringido únicamente a la address dueña del contrato/proyecto)
 - Función que permita ver las propuestas del proyecto (restringida únicamente a las addresses que tenga W3G), que traiga ID, Título, Descripción, Votos Positivos, Votos Negativos y Estado (será Abierta mientras la fecha límite de la propuesta sea mayor a hoy; sino será Cerrada)

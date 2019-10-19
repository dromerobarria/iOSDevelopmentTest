
# Roadmap
👎 - No funciona offline / No tiene persistencia de datos * Solo funciona conectada a internet.

Solución: Se genera manejo offline y online de la App , se agrego persistencia con REALM que permite funcionar offline como online pero al activar servidor se prioriza la información arriba en vez de la local.

TODO: Permitir funcionalidad mixta, el problema radica en que no existe endpoint para actualizar contadores sino acciones por separado. El mayor problema es que al tener respuesta del servidor se debera actualizar lo local al server (siendo el mayor problema que el endpoint de crear counter acepta un nombre y no "id" o "count" eso deriva a tener que encadenar llamadas para actualizar en counter.

👎 Bad UI/UX * La UI busca ser simple (que no está mal) pero en este caso está descuidada, solo se usaron componentes nativos sin cuidar aspectos de alineación y en general parece un "ejemplo" de app mas que una app "Lista para la App Store".

Solución: En este caso, se puede mejorar componentes pero por tiempo se trato de hacer simple. Es verdad es mas un ejemplo que una App para subir.

👎 Código sin usar * Hay demasiadas partes del código que están creadas pero con implementación vacía como si se necesitasen para algo que nunca ocurrió y quedaron muchos archivos que no deberían estar que no hacen nada.

Solución: Lamentablemnte se menciono el uso de templates de Clean Swift, y eso si genera clases vacias (las cuales no quiera decir que no deban existir) a criterio personal perfiero tenerlas que no tenerlas para estructura de la App.

👎 Tests de unidad * Esto no es algo malo!, pero la implementación no es correcta, busca realizar test que permitan testear la aplicación pero no aseguran el funcionamiento dado que implementa algunos casos. Adicionalmente la cantidad de código embebido en el ambito de los tests para crear mocks lo hace desordenado.

Solución: Totalmente de acuerdo, los test son de ejemplo y no prueban ninguna funcionalidad fundamental de la App.... pero claro mi criterio fue "XCTests are good" no "XCTests are good and must be funtional as the App required".


# Respuesta

✅ Aspectos positivos
👍 Uso de arquitectura clean/viper para el código. * En general ayuda a mantener el código solo con responsabilidades asociadas.
👍 Localization (traducciones) * Tiene una base de traducciones.
👍 Manejo de errores user friendly * Cuando la app no tiene conexión se muestra info al usuario del problema de una manera correcta.
👍 Soporta dispositivos de manera universal * Funciona en iPhone y iPad

🙅‍♂️ Aspectos negativos
👎 No funciona offline / No tiene persistencia de datos * Solo funciona conectada a internet.
👎 Bad UI/UX * La UI busca ser simple (que no está mal) pero en este caso está descuidada, solo se usaron componentes nativos sin cuidar aspectos de alineación y en general parece un "ejemplo" de app mas que una app "Lista para la App Store".
👎 Código sin usar * Hay demasiadas partes del código que están creadas pero con implementación vacía como si se necesitasen para algo que nunca ocurrió y quedaron muchos archivos que no deberían estar que no hacen nada.
👎 Tests de unidad * Esto no es algo malo!, pero la implementación no es correcta, busca realizar test que permitan testear la aplicación pero no aseguran el funcionamiento dado que implementa algunos casos. Adicionalmente la cantidad de código embebido en el ambito de los tests para crear mocks lo hace desordenado.




# Consideraciones

Para la implementación de la network layer se utilizo Alamofire.

En Constans se puede encontrar la URL (en "testUrl") para modificar en caso de probar hacia otra dirección , actualmente es http://localhost:3000.

Se utilizo la arquitectura Clean Swift , utilizando sus templates junto a la documentación de Apple (en el caso de la searchBar, la cual solo tiene la funcionalidad de buscar y no editar sus elementos).

XCTest:

func testNumberOfSectionsInTableViewShouldAlwaysBeOne()

func testPresentFetchedProductsShouldAskViewControllerToDisplayFetchedProducts()

func testNumberOfRowsInAnySectionShouldEqaulNumberOfProductsToDisplay()


# iOSDevelopmentTest
XXXXX iOS Development Test


XXXXX iOS Development Test
Before you begin

Create a simple iOS app for counting things. You'll need to meet high expectations for quality and functionality. It must meet at least the following:

    Add a named counter to a list of counters.
    Increment any of the counters.
    Decrement any of the counters.
    Delete a counter.
    Show a sum of all the counter values.
    Persist data back to the server.
    Must not feel like a learning exercise. Think you're building this for the App Store.

Some other notes:

    Showing off the capabilities of UIKit and Core frameworks is essential.
    Unreliable networks are a thing. Handle errors.
    This isn't a backend test, don't make it require any databases.
    You can use Swift 4 and the latest beta of Xcode.

Extra points:

    Don't use any external dependencies.
    Lightweight view controllers.
    Showing off some Core Animation knowledge.
    XCTests are good.

A possible app design could be:

+-----------------------------+ | [Edit] Kontwapp [+] | +-----------------------------+ +-----------------------------+ | Cups of tea 5 [-|+] | | Boats I've been on 1 [-|+] | | White shirts 15 [-|+] | +-----------------------------+ +-----------------------------+ | [↑] Total: 21 | +-----------------------------+

Remember: The UI is super important. When in doubt, steal from the system apps. Don't build anything that doesn't feel right for iOS.
Install and start the server

$ npm install $ npm start
API endpoints / examples

The following endpoints are expecting a Content-Type: application/json


``` GET /api/v1/counters [ ]

POST { title: "Coffee" } /api/v1/counter [ { id: "adsf", title: "Coffee", count: 0 } ]

POST { title: "Tea" } /api/v1/counter [ { id: "asdf", title: "Coffee", count: 0 }, { id: "qwer", title: "Tea", count: 0 } ]

POST { id: "asdf" } /api/v1/counter/inc [ { id: "asdf", title: "Coffee", count: 1 }, { id: "qwer", title: "Tea", count: 0 } ]

POST { id: "qwer"} /api/v1/counter/dec [ { id: "asdf", title: "Coffee", count: 1 }, { id: "qwer", title: "Tea", count: -1 } ]

DELETE { id: "qwer" } /api/v1/counter [ { id: "asdf", title: "Coffee", count: 1 } ]

GET /api/v1/counters [ { id: "asdf", title: "Coffee", count: 1 }, ] ```

NOTE: Each request returns the current state of all counters.



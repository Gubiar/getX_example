import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageHome(),
    );
  }
}

//Classe separada com toda a lógica de negócio do seu aplicativo
//Separar dos Widgets (Mais fácil manutenção)
class Counter extends GetxController {
  RxInt _counter = 0.obs;
  void _incrementCounter() => _counter++;
}

//Seu Widget Stateless
class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Cria uma instancia da classe contentdo a lógica
    //Tag permanent caso queria criar um Singleton
    //Se for usar a classe em outra tela basta usar Counter counter2 = Get.find<Counter>();
    Counter counter = Get.put(Counter(), permanent: true);

    AppBar appBar = AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageDois()),
            )
          },
          icon: const Icon(Icons.navigate_next_rounded)
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - appBar.preferredSize.height,
        child: Center(
          child: Obx(() => Text('Você clicou ${counter._counter.toString()} vezes')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter._incrementCounter(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

//Seu Widget Stateless
class PageDois extends StatelessWidget {
  const PageDois({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Cria uma instancia da classe contentdo a lógica
    //Tag permanent caso queria criar um Singleton
    //Se for usar a classe em outra tela basta usar Counter counter2 = Get.find<Counter>();
    Counter counter2 = Get.find<Counter>();

    AppBar appBar = AppBar(
      title: const Text('PageDois'),
    );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - appBar.preferredSize.height,
        child: Obx(() => Text('Você clicou ${counter2._counter.toString()} vezes')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter2._incrementCounter(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

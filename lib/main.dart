import 'package:flutter/material.dart';
import 'api_service.dart';
import 'estado.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBGE Estados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EstadosList(),
    );
  }
}

class EstadosList extends StatefulWidget {
  @override
  _EstadosListState createState() => _EstadosListState();
}

class _EstadosListState extends State<EstadosList> {
  late Future<List<Estado>> futureEstados;

  @override
  void initState() {
    super.initState();
    futureEstados = ApiService.fetchEstados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estados do Brasil'),
      ),
      body: Center(
        child: FutureBuilder<List<Estado>>(
          future: futureEstados,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Estado> estados = snapshot.data!;
              return ListView.builder(
                itemCount: estados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(estados[index].nome),
                    subtitle: Text(estados[index].sigla),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

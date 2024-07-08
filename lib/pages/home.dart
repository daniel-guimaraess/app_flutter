import 'package:app/repositories/alert_repository.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth * 0.4;
    final table = AlertRepository.table;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bem vindo, Daniel!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: squareSize,
                height: squareSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Alertas hoje',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                width: squareSize,
                height: squareSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Análises hoje',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Últimos alertas',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int alert) {
                return ListTile(
                  leading: SizedBox(
                    child: Image.network(table[alert].img),
                    width: 50,
                  ),
                  title: Text(
                    table[alert].detection,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(table[alert].date),
                );
              },
              padding: const EdgeInsets.only(left: 15, right: 15),
              separatorBuilder: (_, __) => const Divider(
                height: 5,
              ),
              itemCount: table.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              alignment: Alignment.center,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 253, 94, 147),
                    Color.fromARGB(255, 0, 136, 248),
                  ],
                ),
              ),
              child: const Text(
                'ANÁLISE GEMINI AI',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}

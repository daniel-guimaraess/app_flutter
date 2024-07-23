import 'package:app/models/pet.dart';
import 'package:app/repositories/pet_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPetsPage extends StatefulWidget {
  const MyPetsPage({super.key});

  @override
  State<MyPetsPage> createState() => MyPetsPageState();
}

class MyPetsPageState extends State<MyPetsPage> {
  late List<Pet> allPets;
  late PetRepository pets;

  @override
  Widget build(BuildContext context) {
    pets = context.watch<PetRepository>();
    allPets = pets.allPets;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Pets',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 75, 134),
      ),
      body: RefreshIndicator(
        onRefresh: () => pets.checkPets(),
        color: Colors.black,
        child: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: allPets.length,
          itemBuilder: (context, index) {
            final pet = allPets[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              elevation: 4.0,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: pet.imgUrl.isNotEmpty
                    ? SizedBox(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            allPets[index].imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.pets,
                          size: 80,
                          color: Colors.grey[700],
                        ),
                      ),
                title: Text(
                  pet.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.type == 'cat' ? 'Gato' : '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Peso: ${pet.weight} kg',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Aniversário: ${pet.dateBirth}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Icon(Icons.edit),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

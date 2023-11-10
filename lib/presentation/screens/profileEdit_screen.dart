import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../providers/user_provider.dart';


class UpgradeProfileScreen extends ConsumerStatefulWidget{
  const UpgradeProfileScreen({ super.key});

  @override
  UpgradeProfileState createState() => UpgradeProfileState();

}

class UpgradeProfileState extends ConsumerState{
  @override
  void initState(){
    super.initState();
    ref.read(userProvider.notifier).getUserById();
  }

  @override
  Widget build(BuildContext context){

    final userState = ref.watch(userProvider);
    final user = userState.user;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            context.go('/profile');
          },
              icon: const Icon(LineAwesomeIcons.angle_left)),
          title: Text('Editar Perfil'),

        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),child: Image.network('${user?.imageData}',fit: BoxFit.cover)),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(255, 97, 189, 215)
                          ),
                          child: const Icon(
                              LineAwesomeIcons.camera,
                              size: 20 ,
                              color: Colors.black
                          ),
                      ),
                    ),
                 ],
                ),
                const SizedBox(height: 50),
                Form(child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(label:Text('${user?.userFirstName}'),prefixIcon: const Icon(Icons.person_2_sharp)),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(label:Text('${user?.userLastName}'),prefixIcon: const Icon(Icons.person_rounded)),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(label:Text('${user?.userEmail}'),prefixIcon: const Icon(Icons.email)),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(label:Text('${user?.userPhone}'),prefixIcon: const Icon(Icons.phone)),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration:  InputDecoration(label:Text('${user?.userBirthDate}'),prefixIcon: const Icon(Icons.cake)),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          context.go('/profile');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 97, 189, 215)),
                        child: const Text("Editar",style: TextStyle(color:Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none
                            ),
                        child: const Text("Deshacer Cambios", style: TextStyle(color: Colors.red),),
                      ),
                    )
                    
                  ]
                ))
              ]
            ),
          ),
        )
    );
  }

}
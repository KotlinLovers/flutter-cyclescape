
import 'package:cyclescape/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../presentation/widgets/bicycle_operatios.dart';

class ProfileScreen extends ConsumerStatefulWidget{
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() =>ProfileScreenState();
}

class ProfileScreenState extends ConsumerState{

  @override
  void initState(){
    super.initState();
    ref.read(userProvider.notifier).getUserById();
  }

  @override
  Widget build(BuildContext context){

    final userState = ref.watch(userProvider);
    final user = userState.user;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Colors.deepOrange: Colors.blueAccent;

    return Scaffold(
      //drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.go('/');
        },icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text('Mi perfil'),
        actions: [
          IconButton(onPressed: (){},icon: Icon(isDark? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
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
                        borderRadius: BorderRadius.circular(100),child:  Image.network('${user?.imageData}',fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.deepOrange
                        ),
                        child: const Icon(
                            LineAwesomeIcons.alternate_pencil,
                            size: 20 ,
                            color: Colors.black)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text('${user?.userFirstName} ${user?.userLastName}',style: Theme.of(context).textTheme.bodyLarge),
              Text('${user?.userEmail}',style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height:20),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: (){
                      context.go('/profile-edit');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,side: BorderSide.none, shape:const StadiumBorder()),
                    child: const Text('Editar perfil', style: TextStyle(color: Colors.white))
                  )
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.directions_bike),
                title: Text('Publicar Bicicletas'),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // Navegar a BicycleOperation
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BicycleOperation()),
                  );
                },
              ),
              ///Menu
              ProfileMenuWidget(title: "Bicicletas publicadas",icon: LineAwesomeIcons.bicycle,onPress: (){}),

              ProfileMenuWidget(title: "Administración de cuenta",icon: LineAwesomeIcons.user_check,onPress: (){}),
              ProfileMenuWidget(title: "Detalles de pago",icon: LineAwesomeIcons.wallet,onPress: (){}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Cerrar sesión",icon: LineAwesomeIcons.alternate_sign_out,textColor: Colors.red,endIcon: false, onPress: (){}),
            ],
          ),
        ),
      ),
    );

  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({

    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,

    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40, height: 40,
        decoration:
          BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.tealAccent.withOpacity(0.1)
          ),
        child: Icon(icon, color: Colors.blueAccent),
      ),
      title: Text(title,style: Theme.of(context).textTheme.bodyMedium?.apply(color:textColor)),
      trailing: endIcon? Container(
        width: 30, height: 30,
        decoration:
        BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)
        ),
        child: Icon(LineAwesomeIcons.angle_right,size: 18.0 ,color: Colors.grey)): null,
    );
  }
}


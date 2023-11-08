import 'package:cyclescape/presentation/providers/auth_provider.dart';
import 'package:cyclescape/presentation/providers/user_provider.dart';
import 'package:cyclescape/presentation/screens/loading_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).getUserById();
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      await ref.read(userProvider.notifier).getUserById();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Color _baseColor(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.blueGrey[900]!
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final user = userState.user;
    var backgroundColor = _baseColor(context);
    var textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text('Mi perfil'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Theme.of(context).brightness == Brightness.dark
                  ? LineAwesomeIcons.sun
                  : LineAwesomeIcons.moon))
        ],
        backgroundColor: backgroundColor,
        elevation: 0, // Remove the shadow
      ),
      body: isLoading ? LoadingScreen() : 
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: backgroundColor,
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('${user?.imageData}'),
              ),
              const SizedBox(height: 10),
              Text('${user?.userFirstName} ${user?.userLastName}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: textColor)),

              Text('${user?.userEmail}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: textColor)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go('/profile-edit');
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                child: const Text('Editar perfil'),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              ///Menu
              ProfileMenuWidget(
                title: "Bicicletas publicadas",
                icon: LineAwesomeIcons.bicycle,
                onPress: () {},
                textColor: textColor,
              ),
              ProfileMenuWidget(
                title: "Administración de cuenta",
                icon: LineAwesomeIcons.user_check,
                onPress: () {},
                textColor: textColor,
              ),
              ProfileMenuWidget(
                title: "Detalles de pago",
                icon: LineAwesomeIcons.wallet,
                onPress: () {},
                textColor: textColor,
              ),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Cerrar sesión",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  ref.read(authProvider.notifier).logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends ConsumerStatefulWidget {
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
  ConsumerState<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends ConsumerState<ProfileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onPress,
      leading: CircleAvatar(
        backgroundColor: Colors.tealAccent.withOpacity(0.1),
        child: Icon(widget.icon, color: Colors.blueAccent),
      ),
      title: Text(
        widget.title,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: widget.textColor),
      ),
      trailing: widget.endIcon
          ? Icon(LineAwesomeIcons.angle_right, color: Colors.grey)
          : null,
    );
  }
}

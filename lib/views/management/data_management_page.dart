import 'package:app/global_resource.dart';
import 'package:app/views/home/components/appbar.dart';

class DataManagementPage extends StatelessWidget {
  const DataManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HoraAppBar(
        context,
        title: const Text('Data Manajemen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: colorBlueOpacity,
                ),
                child: const Row(
                  children: [
                    Text(
                      'Interval',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ManagementCard(
            title: 'Hadir',
            description:
                'Data kehadiran akan dikirimkan ke alamat email yang terdaftar di Hora.',
            onShareEmail: () {},
          ),
          ManagementCard(
            title: 'Cuti',
            description:
                'Data cuti akan dikirimkan ke alamat email yang terdaftar di Hora.',
            onShareEmail: () {},
          ),
          ManagementCard(
            title: 'Izin',
            description:
                'Data izin akan dikirimkan ke alamat email yang terdaftar di Hora.',
            onShareEmail: () {},
          ),
        ],
      ),
    );
  }
}

class ManagementCard extends StatelessWidget {
  const ManagementCard({
    super.key,
    required this.title,
    required this.description,
    required this.onShareEmail,
  });

  final String title;
  final String description;
  final VoidCallback onShareEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: colorBlueOpacity,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: colorBlackPrimary,
            ),
            padding: const EdgeInsets.symmetric(vertical: 24),
            alignment: Alignment.center,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FeatherIcons.share, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Bagikan ke email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NgoProfilePageState extends State<NgoProfilePage> {
  bool _isEditing = false;
  int _selectedIndex = 3; //Profile tab

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  String ngoLogoAsset = 'assets/ngo_logo.png';


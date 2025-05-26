
class _NgoProfilePageState extends State<NgoProfilePage> {
  bool _isEditing = false;
  int _selectedIndex = 3; //Profile tab

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  String ngoLogoAsset = 'assets/ngo_logo.png';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Ngo Name');
    _emailController = TextEditingController(text: 'ngo@gmail.com');
    _phoneController = TextEditingController(text: '+1234567890');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



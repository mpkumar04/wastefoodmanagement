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


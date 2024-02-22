import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _selectedAgeRange;
  final List<String> ageRanges = ['8-12', '13-18'];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_selectedAgeRange != null) {
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(username: 'JohnDoe')),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: const Text('Please enter both email and password.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('Please select an age range.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _signIn() {
    // Implement sign-in functionality here
    print('Sign in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButtonFormField<String>(
                        value: _selectedAgeRange,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedAgeRange = value;
                          });
                        },
                        items: ageRanges.map((String range) {
                          return DropdownMenuItem<String>(
                            value: range,
                            child: Text(range),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Age Range',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: _login,
                        child: Text('Login'),
                        color: Colors.teal,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: _signIn,
                        child: Text('Sign In'),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedTabTitle;
  bool _showBackButton = false;

  void _search() {
    setState(() {
      String searchText = _searchController.text.toLowerCase();
      bool found = false;
      for (String tabTitle in ['Puberty', 'Parenthood', 'STDs', 'Reproductive System']) {
        if (tabTitle.toLowerCase().contains(searchText)) {
          _selectedTabTitle = tabTitle;
          _showBackButton = true;
          found = true;
          break;
        }
      }
      if (!found) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Result Not Found'),
              content: Text('No match found for "$searchText"'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showBackButton ? const Text('Search Result') : const Text('Home Page'),
        automaticallyImplyLeading: _showBackButton,
        actions: _showBackButton
            ? []
            : [
          IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Search'),
                    content: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: _search,
                        child: Text('Search'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.search),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign out'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: _selectedTabTitle != null
          ? _buildSelectedTab(context, _selectedTabTitle!)
          : _buildGridTabs(context),
      floatingActionButton: IconButton(
        onPressed: () {
          // Handle the chatbot action
        },
        icon: Image.network(
          'https://media.istockphoto.com/id/1060696342/vector/robot-icon-chat-bot-sign-for-support-service-concept-chatbot-character-flat-style.jpg?s=612x612&w=0&k=20&c=t9PsSDLowOAhfL1v683JMtWRDdF8w5CFsICqQvEvfzY=',
          fit: BoxFit.cover,
          width: 80, // Adjust the size as needed
          height: 85, // Adjust the size as needed
        ),
        //backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _buildSelectedTab(BuildContext context, String title) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title == 'Reproductive System') // Conditionally display image
              CircleAvatar(
                radius: 50,
                child: Image.network(
                  _getTabImageUrl(title),
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTabs(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildTab(context, 'Puberty',
                  'https://thumbs.dreamstime.com/z/adolescent-girlfriend-boyfriend-starting-romantic-relationship-learning-physical-attraction-puberty-emotional-health-221775710.jpg'),
              _buildTab(context, 'Parenthood',
                  'https://static.vecteezy.com/system/resources/previews/027/791/886/non_2x/family-with-children-embracing-love-family-support-parenthood-concept-vector.jpg'),
              _buildTab(context, 'STDs',
                  'https://media.istockphoto.com/id/1440822300/vector/prostate-cancer-urologist-examines-male-genitourinary-system-diagnosis-of-prostatitis-or.jpg?s=612x612&w=0&k=20&c=ksJRZAu5CN3UJ08cpbJdBLF_D2-D_tou91PahPQ8rMY='),
              _buildTab(
                  context,
                  'Reproductive System',
                  'https://www.shutterstock.com/shutterstock/photos/2322594781/display_1500/stock-vector-reproductive-system-clipart-cartoon-style-doctor-presenting-human-reproductive-system-at-medical-2322594781.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TabPage(title: title),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTabImageUrl(String title) {
    switch (title) {
      case 'Puberty':
        return 'https://thumbs.dreamstime.com/z/adolescent-girlfriend-boyfriend-starting-romantic-relationship-learning-physical-attraction-puberty-emotional-health-221775710.jpg';
      case 'Parenthood':
        return 'https://static.vecteezy.com/system/resources/previews/027/791/886/non_2x/family-with-children-embracing-love-family-support-parenthood-concept-vector.jpg';
      case 'STDs':
        return 'https://media.istockphoto.com/id/1440822300/vector/prostate-cancer-urologist-examines-male-genitourinary-system-diagnosis-of-prostatitis-or.jpg?s=612x612&w=0&k=20&c=ksJRZAu5CN3UJ08cpbJdBLF_D2-D_tou91PahPQ8rMY=';
      case 'Reproductive System':
        return 'https://www.shutterstock.com/shutterstock/photos/2322594781/display_1500/stock-vector-reproductive-system-clipart-cartoon-style-doctor-presenting-human-reproductive-system-at-medical-2322594781.jpg';
      default:
        return '';
    }
  }
}

class TabPage extends StatelessWidget {
  final String title;

  const TabPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Content for $title',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

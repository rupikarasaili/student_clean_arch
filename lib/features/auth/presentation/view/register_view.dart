import 'package:flutter/material.dart';

import '../../../../common/snackbar.dart';
import '../../../../model/student.dart';



class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final gap = const SizedBox(height: 8);
  List<String> batches = [
    "30A",
    "30B",
    "29A",
    "29B",
  ];
  List<String> courses = ['Computing', 'Ethical Hacking', 'Multimedia'];

  List<Student> lstStudent = [];

  // Controllers for TextFormFields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final batchController = TextEditingController();
  final courseController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedBatch;
  String? selectedCourse;
  final key = GlobalKey<FormState>();

  void _userCheck(String username, String password) {
    for (var i = 0; i < lstStudent.length; i++) {
      if (lstStudent[i].username == username &&
          lstStudent[i].password == password) {
        showSnackbar(context, 'Logged in successfully');
        Navigator.pushNamed(context, '/dashboardRoute',
            arguments: lstStudent[i]);
        return;
      }
    }
    showSnackbar(context, 'Invalid phone or password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                gap,
                DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select batch';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Batch',
                    border: OutlineInputBorder(),
                  ),
                  items: batches
                      .map(
                        (batch) => DropdownMenuItem(
                          value: batch,
                          child: Text(batch),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBatch = value;
                    });
                  },
                ),
                gap,
                DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select course';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Course',
                    border: OutlineInputBorder(),
                  ),
                  items: courses
                      .map(
                        (course) => DropdownMenuItem(
                          value: course,
                          child: Text(course),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCourse = value;
                    });
                  },
                ),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username ';
                    }
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password ';
                    }
                    return null;
                  },
                ),
                gap,
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    hintText: 'Confirm your password',
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password ';
                    }
                    if (value != passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                gap,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        final newUser = Student(
                          fname: firstNameController.text,
                          lname: lastNameController.text,
                          phone: int.parse(phoneController.text),
                          batch: selectedBatch,
                          course: selectedCourse,
                          password: passwordController.text,
                        );
                        lstStudent.add(newUser);
                        showSnackbar(context, "Account Created Successfully");

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/loginRoute',
                          (route) => true,
                        );
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
                // gap,
                // TextButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/loginRoute');
                //   },
                //   child: const Text('Login'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/services/auth_services.dart';
import 'package:tasks_app/utils/app_colors.dart';
import 'package:tasks_app/utils/widgets/my_text_form_field.dart';
import 'package:tasks_app/views/todos_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors().SecondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logos/link_you_logo.png'),
                const SizedBox(height: 12),
                const Text(
                  'Welcome to your Todos Manager!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 12),
                MyTextFormField(
                  controller: usernameController,
                  label: "Username",
                  labelIcon: Icons.person,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your username"
                      : null,
                ),
                MyTextFormField(
                  controller: passwordController,
                  label: "Password",
                  labelIcon: Icons.lock,
                  obsecureText: true,
                  isPassword: true,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your password"
                      : null,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().PrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                          padding: const EdgeInsets.all(12)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var user = await AuthService().signIn(
                              usernameController.text, passwordController.text);

                          if (user.isEmpty) {
                            const snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'On Snap!',
                                message:
                                    'Check your credentials and try again! or your   network maybe?',
                                contentType: ContentType.failure,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);

                            print("failed");
                          } else {
                            print(user);
                            print("Success");

                            const snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Welcome!',
                                message:
                                    'You have successfully signed in! Start managing your todos now!',
                                contentType: ContentType.success,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodosPage(),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TodosPage()));
                  },
                  child: Text(
                    "Skip",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

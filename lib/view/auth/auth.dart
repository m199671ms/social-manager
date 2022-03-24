import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:social_manager/generated/l10n.dart';
import 'package:social_manager/models/user.dart';
import 'package:social_manager/utils/api_handler.dart';
import 'package:social_manager/utils/helper.dart';
import 'package:social_manager/utils/store.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ScrollController scrollController = ScrollController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              forceElevated: true,
              floating: true,
              pinned: true,
              primary: true,
              bottom: TabBar(
                indicatorColor: Colors.red,
                onTap: (_) {
                  scrollController.animateTo(
                    kToolbarHeight + 250,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                tabs: [
                  Tab(
                    text: S.of(context).login,
                  ),
                  Tab(
                    text: S.of(context).signup,
                  ),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 2,
                collapseMode: CollapseMode.parallax,
                title: Text(
                  S.of(context).welcome,
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                centerTitle: true,
                stretchModes: StretchMode.values,
                background: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xffE3E3BB),
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 130.0, horizontal: 24.0),
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.zero,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(55),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0,
                          ),
                          child: Builder(builder: (context) {
                            return Column(
                              children: [
                                SizeTransition(
                                  sizeFactor: DefaultTabController.of(context)
                                          ?.animation ??
                                      const AlwaysStoppedAnimation(0.0),
                                  child: TextFormField(
                                    controller: _nameController,
                                    validator: (str) => _validateIfNeeded(
                                      context,
                                      str,
                                      _nameValidator,
                                    ),
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enableSuggestions: true,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).user_name,
                                      icon: const Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _phoneController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  validator: _phoneValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).phone_no,
                                    icon: const Icon(Icons.phone),
                                  ),
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  validator: _passwordValidator,
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).password,
                                    icon: const Icon(Icons.password),
                                  ),
                                ),
                                SizeTransition(
                                  sizeFactor: DefaultTabController.of(context)
                                          ?.animation ??
                                      const AlwaysStoppedAnimation(0.0),
                                  child: TextFormField(
                                    controller: _rePasswordController,
                                    textInputAction: TextInputAction.next,
                                    obscureText: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (str) => _validateIfNeeded(
                                      context,
                                      str,
                                      _rePasswordValidator,
                                    ),
                                    enableSuggestions: true,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).password_again,
                                      icon: const Icon(Icons.password),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.zero,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(55),
                        ),
                      ),
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      clipBehavior: Clip.antiAlias,
                      child: Builder(builder: (context) {
                        return InkWell(
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (DefaultTabController.of(context)!.index ==
                                  0) {
                                Helper.doAsync<User>(
                                  future: ApiHandler.login(
                                      phone: _phoneController.text,
                                      password: _passwordController.text),
                                  context: context,
                                  onDone: (results) async {
                                    Store.user = results;
                                    await Future.delayed(
                                        const Duration(milliseconds: 50));
                                    Navigator.pushNamed(context, 'home');
                                  },
                                  onGenericError: (e, s) {
                                    if (e == 404) {
                                      Helper.showError(
                                          context: context,
                                          subtitle:
                                              S.of(context).wrong_credentials);
                                    } else {
                                      Helper.showConnectionError(
                                          context: context);
                                    }
                                  },
                                );
                              } else {
                                Helper.doAsync<User>(
                                    future: ApiHandler.signup(
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      password: _passwordController.text,
                                    ),
                                    context: context,
                                    onDone: (results) async {
                                      Store.user = results;
                                      await Future.delayed(
                                          const Duration(milliseconds: 50));
                                      Navigator.pushNamed(context, 'home');
                                    },
                                    onGenericError: (e, s) {
                                      if (e == 409) {
                                        Helper.showError(
                                            context: context,
                                            subtitle: S
                                                .of(context)
                                                .this_phone_is_already_taken);
                                      } else {
                                        Helper.showConnectionError(
                                            context: context);
                                      }
                                    });
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).login,
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiaryContainer,
                                      ),
                                ),
                                const SizedBox(width: 16.0),
                                Icon(
                                  Icons.login,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final Map<String, bool> _validatedPhones = <String, bool>{};
  String? _validateIfNeeded(
      BuildContext context, String? str, String? Function(String?) validator) {
    if (DefaultTabController.of(context)!.index == 1) return validator(str);
    return null;
  }

  String? _empty(String? str, String field) {
    if (str?.isEmpty ?? true) return S.of(context).invalid_field(field);
    return null;
  }

  String? _phoneValidator(String? str) {
    if (_validatedPhones.containsKey(str)) {
      if (!_validatedPhones[str]!) {
        return S.of(context).invalid_field(S.of(context).phone_no);
      }
      return null;
    }
    String? isEmpty = _empty(str, S.of(context).phone_no);
    if (isEmpty != null) return isEmpty;
    if (str!.length != 10) return S.of(context).phone_number_must_be_length(10);
    PhoneNumberUtil().validate(str, 'SD').then((value) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _validatedPhones[str] = value;
        setState(() {});
      });
    });
    return null;
  }

  String? _passwordValidator(String? str) {
    String? isEmpty = _empty(str, S.of(context).password);
    if (isEmpty != null) return isEmpty;
    if (str!.length < 8) {
      return S
          .of(context)
          .field_must_be_not_less_than_length(S.of(context).password, 8);
    }
    return null;
  }

  String? _rePasswordValidator(String? str) {
    String? isValidPassword = _passwordValidator(str);
    if (isValidPassword != null) return isValidPassword;

    if (str != _passwordController.text) {
      return S.of(context).passwords_dont_match;
    }
    return null;
  }

  String? _nameValidator(String? str) {
    String? isEmpty = _empty(str, S.of(context).user_name);
    if (isEmpty != null) return isEmpty;
    if (str!.length < 8) {
      return S
          .of(context)
          .field_must_be_not_less_than_length(S.of(context).user_name, 8);
    }
    return null;
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/formt.dart';

class FormDemo extends HookWidget {
  const FormDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final myForm = useState<Map<String, dynamic>>({
      'name': '我是初始值',
      'age': 18,
      'phone': 12345678901,
      'email': 'demo@123.com',
      'password': '',
      'description': '',
    });

    final passwordVisible = useState<bool>(false);

    final nameController = useTextEditingController();
    final ageController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final descriptionController = useTextEditingController();

    nameController.value = TextEditingValue(text: myForm.value['name']);
    ageController.value =
        TextEditingValue(text: myForm.value['age'].toString());
    phoneController.value =
        TextEditingValue(text: myForm.value['phone'].toString());
    emailController.value = TextEditingValue(text: myForm.value['email']);
    passwordController.value = TextEditingValue(text: myForm.value['password']);
    descriptionController.value = TextEditingValue(text: myForm.value['description']);

    return Form(
        key: formKey,
        child: Column(children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person, color: Colors.black38, size: 24),
              border: OutlineInputBorder(),
              labelText: '用户名',
              hintText: '请输入用户名',
            ),
            // 自定义校验器
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '用户名不能为空';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: passwordVisible.value,
            maxLength: 8,
            controller: passwordController,
            onChanged: (value) => myForm.value['password'] = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '密码不能为空';
              }
              if (value.length < 6) {
                return '密码不能少于6位';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon:
                  const Icon(Icons.password, color: Colors.black38, size: 24),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: passwordVisible.value ? Colors.grey : Colors.blue,
                ),
                onPressed: () => passwordVisible.value = !passwordVisible.value,
              ),
              border: const OutlineInputBorder(),
              labelText: '密码',
              hintText: '请输入密码',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly,
                NumberRangeTextInputFormatter(min: 0, max: 200),
              ],
              controller: ageController,
              onChanged: (value) => myForm.value['age'] = int.tryParse(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.accessibility_new,
                    color: Colors.black38, size: 24),
                border: OutlineInputBorder(),
                labelText: '年龄',
                hintText: '请输入年龄',
              ),
              // 自定义校验器
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '年龄不能为空';
                }
                return null;
              }),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            maxLength: 11,
            controller: phoneController,
            onChanged: (value) => myForm.value['phone'] = int.parse(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone, color: Colors.black38, size: 24),
              border: OutlineInputBorder(),
              labelText: '手机号',
              hintText: '数字输入框',
            ),
            // 自定义校验器
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '手机号不能为空';
              }
              return null;
            }
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onChanged: (value) => myForm.value['email'] = value,
            decoration: const InputDecoration(
              prefixIcon:
              Icon(Icons.email_rounded, color: Colors.black38, size: 24),
              border: OutlineInputBorder(),
              labelText: '邮箱',
              hintText: '邮箱输入框',
            ),
            // 自定义校验器
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '邮箱不能为空';
              }
              return null;
            }
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: descriptionController,
            onChanged: (value) => myForm.value['description'] = value,
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '描述',
                hintText: '多行输入框,带清空功能',
                suffixIcon: IconButton(
                    onPressed: () {
                      descriptionController.clear();
                    },
                    icon: const Icon(Icons.clear, color: Colors.blue, size: 24))),
          ),
          const SizedBox(height: 20),
          Row(children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const StadiumBorder(),
                minimumSize: const Size(100, 40),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  myForm.value['name'] = nameController.text;
                }
              },
              child: const Text('提交'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: const StadiumBorder(),
                minimumSize: const Size(100, 40),
              ),
              onPressed: () {
                formKey.currentState!.reset();
              },
              child: const Text('重置'),
            )
          ])
        ]));
  }
}

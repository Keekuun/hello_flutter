import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextFieldDemo extends HookWidget {
  const TextFieldDemo({super.key});

  @override
  Widget build(BuildContext context) {
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

    useEffect(
        () => () {
              log('name: ${myForm.value['name'].toString()}');
            },
        [myForm.value['name']]);

    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.text,
          maxLength: 8,
          controller: nameController,
          onChanged: (value) => myForm.value['name'] = value,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person, color: Colors.black38, size: 24),
            border: const OutlineInputBorder(),
            labelText: '用户名',
            errorText: nameController.text.isEmpty ? '用户名不能为空' : null,
            hintText: '文本输入框',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: passwordVisible.value,
          maxLength: 8,
          controller: passwordController,
          onChanged: (value) => myForm.value['password'] = value,
          decoration: InputDecoration(
            prefixIcon:
                const Icon(Icons.password, color: Colors.black38, size: 24),
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible.value ? Icons.visibility_off : Icons.visibility,
                color: passwordVisible.value ? Colors.grey : Colors.blue,
              ),
              onPressed: () => passwordVisible.value = !passwordVisible.value,
            ),
            border: const OutlineInputBorder(),
            labelText: '密码',
            hintText: '请输入密码',
            errorText: passwordController.text.isEmpty ? '密码不能为空' : null,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.number,
          maxLength: 3,
          controller: ageController,
          onChanged: (value) => myForm.value['age'] = int.parse(value),
          decoration: const InputDecoration(
            prefixIcon:
                Icon(Icons.accessibility_new, color: Colors.black38, size: 24),
            border: OutlineInputBorder(),
            labelText: '年龄',
            hintText: '数字输入框',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
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
        ),
        const SizedBox(height: 20),
        TextField(
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
        ),
        const SizedBox(height: 20),
        TextField(
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
        const TextField(
          readOnly: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.front_hand),
            suffixIcon: Icon(Icons.clear),
            prefixIcon: Icon(
              Icons.edit_off_rounded,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: '我是只读的',
            hintText: '我是只读的',
            labelStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          readOnly: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.front_hand),
            suffixIcon: Icon(Icons.clear),
            border: UnderlineInputBorder(),
            labelText: '下划线输入框',
            hintText: '下划线输入框',
            labelStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            // 背景颜色
            fillColor: Color(0xFFB3F4A9),
            // 必须设置为 true，fillColor 才有效
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // borderSide: BorderSide(color: Colors.orange),
            ),
            // 边框，一般下面的几个边框一起设置
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.yellow),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.green),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: '设置颜色',
            labelStyle: TextStyle(color: Colors.lightBlue),
            errorText: null,
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

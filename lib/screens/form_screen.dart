import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Контроллеры для личных данных
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _groupController = TextEditingController();
  final _emailController = TextEditingController();

  // Контроллеры для учебных параметров
  String? _selectedSubject;
  final _topicController = TextEditingController();
  final _dateController = TextEditingController();

  final List<String> _subjects = [
    'Математика',
    'Физика',
    'Химия',
    'Биология',
    'История',
    'Литература',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _groupController.dispose();
    _emailController.dispose();
    _topicController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final info = '''
Имя: ${_nameController.text}
Фамилия: ${_surnameController.text}
Группа / Класс: ${_groupController.text}
Email: ${_emailController.text}
Предмет: $_selectedSubject
Тема: ${_topicController.text}
Дата: ${_dateController.text}
''';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Данные сохранены:\n$info')),
      );
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _surnameController.clear();
    _groupController.clear();
    _emailController.clear();
    _topicController.clear();
    _dateController.clear();
    setState(() => _selectedSubject = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форма учебных данных'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '1. Личные данные',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Имя',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Введите имя' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Фамилия',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Введите фамилию' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _groupController,
                decoration: const InputDecoration(
                  labelText: 'Группа / Класс',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Введите группу' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Электронная почта',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите email';
                  } else if (!value.contains('@')) {
                    return 'Неверный формат email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const Text(
                '2. Учебные параметры',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedSubject,
                decoration: const InputDecoration(
                  labelText: 'Предмет',
                  border: OutlineInputBorder(),
                ),
                items: _subjects
                    .map((subject) => DropdownMenuItem(
                          value: subject,
                          child: Text(subject),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedSubject = value),
                validator: (value) =>
                    value == null ? 'Выберите предмет' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _topicController,
                decoration: const InputDecoration(
                  labelText: 'Тема урока',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Введите тему' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Дата (дд.мм.гггг)',
                  border: OutlineInputBorder(),
                  hintText: 'дд.мм.гггг',
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Введите дату' : null,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                      child: const Text('Сохранить'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _clearForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 51, 109),
                      ),
                      child: const Text('Очистить'),
                    ),
                  
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

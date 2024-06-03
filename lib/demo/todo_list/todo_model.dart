import 'package:uuid/uuid.dart';

class TodoModel {
  // 任务id
  String id;

  // 任务标题
  String title;

  // 任务内容
  String content;

  // 任务备注
  String remark;

  // 任务是否完成
  bool isDone = false;

  // 任务创建时间
  DateTime createTime;

  // 任务更新时间
  DateTime? updateTime;

  // 任务完成时间
  DateTime? doneTime;

  // 任务截止时间
  DateTime? deadline;

  // 任务是否删除
  bool isDeleted = false;

  // 任务是否隐藏-默认false
  bool isHidden = false;

  // 任务是否归档-默认false
  bool isArchived = false;

  // 任务是否重要-默认false
  bool isImportant = false;

  // 任务是否紧急-默认false
  bool isUrgent = false;

  // 任务标签
  List<String> tags = [];

  // 任务优先级
  int priority = 0;

  // 任务完成进度 0-100
  double doneProgress = 0.0;

  // 任务操作人
  String operator = '';

  TodoModel({
    required this.title,
    this.content = '',
    this.isDone = false,
    this.remark = '',
    this.updateTime,
    this.doneTime,
    this.deadline,
    this.isDeleted = false,
    this.isHidden = false,
    this.isArchived = false,
    this.isImportant = false,
    this.isUrgent = false,
    this.tags = const [],
    this.priority = 0,
    this.doneProgress = 0.0,
    this.operator = '',
  })  : assert(title.isNotEmpty),
        assert(content.isNotEmpty),
        id = const Uuid().v4().toString(),
        createTime = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'remark': remark,
      'isDone': isDone,
      'createTime': createTime.millisecondsSinceEpoch,
      'updateTime': updateTime?.millisecondsSinceEpoch,
      'doneTime': doneTime?.millisecondsSinceEpoch,
      'deadline': deadline?.millisecondsSinceEpoch,
      'isDeleted': isDeleted,
      'isHidden': isHidden,
      'isArchived': isArchived,
      'isImportant': isImportant,
      'isUrgent': isUrgent,
      'tags': tags,
      'priority': priority,
      'doneProgress': doneProgress,
      'operator': operator,
    };
  }
}

TodoModel createATodo() {
  var uuid = const Uuid().v4().toString();
  return TodoModel(
      title: '标题${uuid.substring(0, 3)}',
      content: '内容${uuid * 4}',
      remark: '备注${uuid.substring(0, 6)}',
      operator: 'zkk$uuid');
}

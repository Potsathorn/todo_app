import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'appTitle': 'Todo List',
          'create': 'Create',
          'sortBy': 'Sort By',
          'title': 'Title',
          'description': 'Description',
          'id': 'ID',
          'selectImage': 'Select Image',
          'date': 'Date',
          'status': 'Status',
          'back': 'Back',
          'ok': 'OK',
          'update': 'Update',
          'createTask': 'Create Task',
          'UpdateTask': 'Update Task',
          'deleteTask': 'Delete Task',
          'deleteMsg': 'Are you sure you want to delete this task?',
          'errorText': 'Please input data',
          'searchHint': 'Title, Description',
          'language': 'Language'
        },
        'th_TH': {
          "appTitle": "รายการสิ่งที่ต้องทำ",
          "create": "สร้าง",
          "sortBy": "เรียงตาม",
          "title": "หัวข้อ",
          "description": "คำอธิบาย",
          "id": "รหัส",
          "selectImage": "เลือกรูปภาพ",
          "date": "วันที่",
          "status": "สถานะ",
          "back": "ย้อนกลับ",
          "ok": "ตกลง",
          "update": "อัปเดต",
          "createTask": "สร้างงาน",
          "updateTask": "แก้ไขงาน",
          "deleteTask": "ลบงาน",
          "deleteMsg": "คุณแน่ใจหรือไม่ว่าต้องการลบงานนี้?",
          'errorText': 'กรุณาระบุข้อมูล',
          'searchHint': 'หัวข้อ, คำอธิบาย',
          'language': 'ภาษา'
        }
      };
}

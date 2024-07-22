import 'package:flutter/material.dart';
import '../component/custom_text_field.dart';
import '../const/colors.dart';
import '../component/progress_dropdown.dart';
import '../component/category_dropdown.dart';



class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5 + bottomInset,
        color: Colors.white,
        child: Padding(
          padding : EdgeInsets.only(left: 8, right : 8, top: 8, bottom: bottomInset),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: '시작일',
                      isTime: true,
                    ),
                  ),
                  const SizedBox(width:16.0),
                  Expanded(
                    child: CustomTextField(
                      label: '종료일',
                      isTime: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Container(
                  alignment: Alignment.topLeft ,
                  child: Text('진행상태')
              ),
              SizedBox(height: 8),
              Container(
                height: 50,
                child: ProgressDropdown(),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft ,
                child: Text('카테고리')
              ),
              Container(
                height: 50,
                child: CategroyDropdown(),
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: CustomTextField(
                  label: '작업량',
                  isTime: false,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 서버에 보낼 함수 API 연동
                    onSavePressed;

                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: main_color,
                  ),
                  child: Text('저장'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 서버에 전송
  void onSavePressed() {

  }
}


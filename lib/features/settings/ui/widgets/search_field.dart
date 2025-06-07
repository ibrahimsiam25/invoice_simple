import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const SearchField({super.key, this.controller, this.onChanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  stt.SpeechToText? _speech;
  bool _isListening = false;

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  void _onMicPressed() async {
    if (_isListening) {
      await _stopListening();
      return;
    }
    if (_speech != null && (_speech!.isListening)) {
      await _speech!.stop();
    }
    _speech = stt.SpeechToText();
    bool available = await _speech!.initialize(
      onStatus: (val) async {
        if (val == 'done' || val == 'notListening') {
          setState(() => _isListening = false);
          await _speech!.stop();
        }
      },
      onError: (val) async {
        setState(() => _isListening = false);
      },
    );
    if (available) {
      setState(() => _isListening = true);
      await _speech!.listen(
        onResult: (val) async {
          if (widget.controller != null) {
            widget.controller!.text = val.recognizedWords;
            widget.controller!.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller!.text.length),
            );
          }
          if (widget.onChanged != null) {
            widget.onChanged!(val.recognizedWords);
          }
          if (val.finalResult) {
            await _stopListening();
          }
        },
      );
    }
  }

  Future<void> _stopListening() async {
    if (_speech != null && _speech!.isListening) {
      await _speech!.stop();
    }
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.circular(10.r);

    return Container(
      height: 48,
      decoration: BoxDecoration(color: AppColors.greyLight2, borderRadius: borderRadius),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.greyDark2, size: 24.sp),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: AppTextStyles.poFont20BlackWh400
                    .copyWith(
                      fontSize: 17.sp,
                      color: AppColors.greyDark2),
                border: InputBorder.none,
                isDense: true,
              ),
              style: TextStyle(
                color: AppColors.greyDark2,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: AppColors.greyDark2,
            ),
          ),
          GestureDetector(
            onTap: _onMicPressed,
            child: Icon(
              _isListening ? Icons.mic_none  : Icons.mic,
              color: _isListening ? Colors.blue : AppColors.greyDark2
              ,
              size: 24.sp
            ),
          ),
        ],  
      ),
    );  
  }
}

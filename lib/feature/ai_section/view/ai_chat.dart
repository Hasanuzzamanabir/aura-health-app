import 'package:aurahealth/feature/ai_section/widgets/chat_bubble_widget.dart';
import 'package:aurahealth/feature/ai_section/widgets/chat_suggestion_chips.dart';
import 'package:aurahealth/feature/ai_section/widgets/suggested_meal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aurahealth/core/theme/app_colors.dart';
import 'package:aurahealth/core/widget/custom_app_bar.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  static const String aiChatScreen = '/aiChatScreen';

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hi Emma! How can I help you today?",
      "isMe": false,
      "hasCustomContent": false,
    },
    {
      "text": "What should I eat after my workout?",
      "isMe": true,
      "hasCustomContent": false,
    },
    {
      "text": "Great question! Here are some high-protein options to support muscle recovery.",
      "isMe": false,
      "hasCustomContent": true,
    },
  ];

  final List<String> _suggestions = [
    "Adjust my calories",
    "Recovery meal ideas",
    "Workout plan",
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "text": text.trim(),
        "isMe": true,
        "hasCustomContent": false,
      });
    });

    _messageController.clear();
    
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const CustomAppBar(title: "AI Coach", isBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
<<<<<<< HEAD
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return ChatBubbleWidget(
                    text: msg["text"],
                    isMe: msg["isMe"],
                    customContent: msg["hasCustomContent"]
                        ? SizedBox(
                            height: 155.h,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: const [
                                SuggestedMealCard(
                                  imageUrl: "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=500&q=80",
                                  title: "Protein Smoothie",
                                  calories: "300",
                                ),
                                SuggestedMealCard(
                                  imageUrl: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80",
                                  title: "Chicken Bowl",
                                  calories: "520",
                                ),
                              ],
                            ),
                          )
                        : null,
                  );
                },
=======
                children: [
                  const ChatBubbleWidget(
                    text: "Hi Emma! How can I help you today?",
                    isMe: false,
                  ),
                  const ChatBubbleWidget(
                    text: "What should I eat after my workout?",
                    isMe: true,
                  ),
                  ChatBubbleWidget(
                    text:
                        "Great question! Here are some high-protein options to support muscle recovery.",
                    isMe: false,
                    customContent: SizedBox(
                      height: 155.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          SuggestedMealCard(
                            imageUrl:
                                "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=500&q=80",
                            title: "Protein Smoothie",
                            calories: "300",
                          ),
                          SuggestedMealCard(
                            imageUrl:
                                "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80",
                            title: "Chicken Bowl",
                            calories: "520",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
>>>>>>> 47fb3b0bb655014028239f643916d5856e6a76a5
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Column(
                children: [
                  ChatSuggestionChips(
                    suggestions: _suggestions,
                    onChipTap: (val) {
                      _sendMessage(val);
                    },
                  ),
                  SizedBox(height: 12.h),
                  TextFormField(
                    controller: _messageController,
<<<<<<< HEAD
                    onFieldSubmitted: (val) => _sendMessage(val),
=======
>>>>>>> 47fb3b0bb655014028239f643916d5856e6a76a5
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 6.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
<<<<<<< HEAD
                              onTap: () => _sendMessage(_messageController.text),
=======
                              onTap: () {
                                if (_messageController.text.trim().isNotEmpty) {
                                  _messageController.clear();
                                }
                              },
>>>>>>> 47fb3b0bb655014028239f643916d5856e6a76a5
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
<<<<<<< HEAD
                                child: Icon(Icons.send, color: AppColors.white, size: 16.sp),
=======
                                child: Icon(
                                  Icons.send,
                                  color: AppColors.white,
                                  size: 16.sp,
                                ),
>>>>>>> 47fb3b0bb655014028239f643916d5856e6a76a5
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

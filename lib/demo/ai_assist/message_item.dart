import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../utils/common.dart';

class MessageItem extends StatelessWidget {
  final bool isAiMessage;
  final String? message;
  final Widget? avatar;
  final Widget? content;

  const MessageItem(
      {super.key,
      this.isAiMessage = false,
      this.message,
      this.avatar,
      this.content});

  @override
  Widget build(BuildContext context) {
    var _isMarkdown = isMarkdown(message ?? '');

    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      child: Align(
        alignment: isAiMessage ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 32 - 22),
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: isAiMessage
                      ? Colors.black12
                      : Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  scrollDirection:
                      _isMarkdown ? Axis.horizontal : Axis.vertical,
                  child: Row(
                      mainAxisAlignment: isAiMessage
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isAiMessage
                            ? const Icon(
                                Icons.person,
                                color: Colors.redAccent,
                                size: 32,
                              )
                            : const Icon(
                                color: Colors.blueAccent,
                                Icons.person,
                                size: 32,
                              ),
                        avatar ?? const SizedBox.shrink(),
                        SizedBox(width: isAiMessage || avatar != null ? 12 : 0),
                        content ??
                            (_isMarkdown
                                ? MarkdownBody(
                                    data: message!,
                                    selectable: true,
                                    softLineBreak: true)
                                : Flexible(
                                    child: Text(
                                      message ?? '（空）',
                                      style: TextStyle(
                                          color: isAiMessage
                                              ? Colors.black
                                              : Colors.white70,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ))
                      ]),
                ),
              )),
        ),
      ),
    );
  }
}
